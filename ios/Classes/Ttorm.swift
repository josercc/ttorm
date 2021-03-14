//
//  Ttorm.swift
//  ttorm
//
//  Created by 张行 on 2021/3/11.
//

import Foundation
/// 模块管理器
public class Ttorm {
    /// 获取单利对象
    public static let manager = Ttorm()
    /// 获取注册模块的对象
    public let register:TtormRegister
    /// 私有初始化 外界只能通过`manager`获取单利
    private init() {
        self.register = TtormRegister()
    }
    
    /// 初始化路由
    /// - Parameter registerHandle: 注册路由回掉
    public func initRoute(_ registerHandle:@escaping((TtormRegister) -> Void)) {
        registerHandle(self.register)
    }
    
    /// 运行App程序
    /// - Parameters:
    ///   - root: 指定入口的路由
    ///   - parameter: 指定路由的参数
    ///   - handle: 初始化`UIViewController`完毕的回掉 可以设置为`UIWindow`的`rootViewController`
    public func runApp(_ root:TtormIdentifier,
                       _ parameter:TtormParameter = TtormParameter(),
                       _ handle:((UIViewController) -> Void)) {
        guard let rootController = register.getController(root, parameter) else {
            assert(false,"\(root.identifier)没有注册")
        }
        handle(rootController)
    }
}
