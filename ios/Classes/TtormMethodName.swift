//
//  TtormMethodName.swift
//  ttorm
//
//  Created by 张行 on 2021/3/9.
//

import Foundation

public enum TtormMethodName:String {
    /// 获取Flutter端已经注册的路由列表
    case getAllRegisterIdentifiers = "get_all_register_identifiers"
    case push = "push"
    case pop = "pop"
    case runFlutterView = "runFlutterView"
}
