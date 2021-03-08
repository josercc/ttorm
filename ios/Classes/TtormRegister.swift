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
    static private var registerMap:[String:TtormGetModelHandle] = [:]
    
    /// 注册路由表
    /// - Parameters:
    ///   - controller: 注册的UIViewController
    ///   - identifier: 注册的唯一标识符 可以不传递 默认为`controller`的类名称
    public static func register<T:Ttorm>(_ controller:T.Type, _ identifier:String? = nil) {
        let ttormIdentifier = identifier ?? "\(controller)"
        let makeControllerHandle:(TtormGetModelHandle) = { parameter in
            return T.ttormMakeController(parameter: parameter)
        }
        registerMap[ttormIdentifier] = makeControllerHandle
    }
    
    public static func getController(_ identifier:String, _ parameter:TtormParameter) -> UIViewController? {
        guard let handle = registerMap[identifier] else {
            return nil
        }
        return handle(parameter)
    }
}

