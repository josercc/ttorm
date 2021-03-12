//
//  Ttorm.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 模块化需要实现的协议
public protocol TtormModule {
    /// 创建对应组件的`UIViewController`
    /// - Parameter parameter: 模块传递过来的参数
    static func ttormMakeController(parameter:TtormParameter) -> UIViewController?
}

