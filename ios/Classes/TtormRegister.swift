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
        let flutterModuleIdentifiers = UserDefaults.standard.object(forKey: "flutterModuleIdentifiers") as? [String] ?? []
        guard !flutterModuleIdentifiers.contains(ttormIdentifier) else {
            assert(false,"\(ttormIdentifier)registered on the flutter side")
            return
        }
        let makeControllerHandle:(TtormGetModelHandle) = { parameter in
            return T.ttormMakeController(parameter: parameter)
        }
        self.registerMap[ttormIdentifier] = makeControllerHandle
        UserDefaults.standard.setValue(self.allRegisterIdentifiers, forKey: "appModelIdentifiers")
        UserDefaults.standard.synchronize()
    }
    
    public func getController(_ identifier:TtormIdentifier, _ parameter:TtormParameter) -> UIViewController? {
        if allRegisterIdentifiers.contains(identifier.identifier) {
            guard let handle = self.registerMap[identifier.identifier] else {
                assert(false,"\(identifier.identifier)没有注册")
                return nil
            }
            return handle(parameter)
        } else {
            let route = "/\(identifier.identifier)?arguments=\(parameter.toJSON() ?? "")"
            let engine = ttormFlutterEngineGroup.makeEngine(withEntrypoint: "main", libraryURI: nil)
            engine.run(withEntrypoint: nil, initialRoute: "/APage")
            let flutterController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
//            flutterController.pushRoute("/APage")
            Ttorm.manager.ttormChannel = FlutterMethodChannel(name: "Ttorm", binaryMessenger: flutterController.binaryMessenger)
            return flutterController
        }
    }
    
    public var allRegisterIdentifiers:[String] {
        return self.registerMap.map({$0.key})
    }
    
    public var flutterModuleIdentifiers:[String] {
        return UserDefaults.standard.object(forKey: "flutterModuleIdentifiers") as? [String] ?? []
    }
}

