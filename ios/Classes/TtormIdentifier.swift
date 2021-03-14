//
//  TtormIdentifier.swift
//  ttorm
//
//  Created by 张行 on 2021/3/11.
//

import Foundation

/// Ttorm模块的标识符
public struct TtormIdentifier {
    /// 标识符字符串
    public let identifier:String
    /// 初始化函数
    /// - Parameter identifier: 标识符字符串
    public init(_ identifier:String) {
        self.identifier = identifier
    }
}
