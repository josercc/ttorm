//
//  TtormRegister.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 注册模块
public class TtormRegister {
    /// 获取模块的定义回掉
    public typealias TtormGetModelHandle = (TtormParameter) -> UIViewController?
    /// 注册在原生的路由表
    private var registerMap:[String:TtormGetModelHandle] = [:]
    
    /// 注册路由表
    /// - Parameters:
    ///   - controller: 注册的UIViewController
    ///   - identifier: 注册的唯一标识符 可以不传递 默认为`controller`的类名称
    public func register<T:TtormModule>(_ controller:T.Type, _ identifier:TtormIdentifier? = nil) {
        let ttormIdentifier = (identifier != nil) ? identifier!.identifier : "\(controller)"
        /// 获取Flutter端已经注册路由
        guard !allRegisterIdentifiers.contains(ttormIdentifier) else {
            assert(false,"\(ttormIdentifier)registered on the flutter side")
            return
        }
        let makeControllerHandle:(TtormGetModelHandle) = { parameter in
            return T.ttormMakeController(parameter: parameter)
        }
        self.registerMap[ttormIdentifier] = makeControllerHandle
    }
    
    /// 通过路由标识符获取对应的`UIViewController`
    /// - Parameters:
    ///   - identifier: 路由的标识符
    ///   - parameter: 路由的参数
    /// - Returns: 可选`UIViewController`
    public func getController(_ identifier:TtormIdentifier,
                              _ parameter:TtormParameter) -> UIViewController? {
        if allRegisterIdentifiers.contains(identifier.identifier) {
            guard let handle = self.registerMap[identifier.identifier] else {
                assert(false,"\(identifier.identifier)没有注册")
                return nil
            }
            return handle(parameter)
        } else {
            guard var urlComponment = URLComponents(string: "TtormRoutes://") else {
                return nil
            }
            urlComponment.queryItems = [
                URLQueryItem(name: "name", value: identifier.identifier),
                URLQueryItem(name: "arguments", value: parameter.toJSON() ?? "")
            ]
            guard let initialRoute = urlComponment.url?.absoluteString else {
                return nil
            }
            let precompiledDartBundle = Bundle(identifier: FlutterDartProject.defaultBundleIdentifier())
            let flutterDartProject = FlutterDartProject(precompiledDartBundle:precompiledDartBundle)
            let flutterController = FlutterViewController(project: flutterDartProject,
                                                          initialRoute: initialRoute,
                                                          nibName: nil,
                                                          bundle: nil)
            return flutterController
        }
    }
    /// 获取原生所有的注册路由
    public var allRegisterIdentifiers:[String] {
        return self.registerMap.map({$0.key})
    }
}

