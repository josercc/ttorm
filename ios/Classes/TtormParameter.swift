//
//  TtormParameter.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 模块跳转传递的参数
public class TtormParameter {
    
    public let parameter:[String:Any]
    
    /// 初始化
    /// - Parameter parameter: 模块化传递过来的参数
    public init(_ parameter:[String:Any] = [:]) {
        self.parameter = parameter
    }
    
    /// 通过`Codable`数据模型生成一个模块化的参数对象
    /// - Parameter model: `Codable`模型
    public init<T:Codable>(_ model:T) {
        guard let data = try? JSONEncoder().encode(model),
              let map = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any] else {
            self.parameter = [:]
            return
        }
        self.parameter = map
    }
    
    public init(_ json:String) {
        guard let data = json.data(using: .utf8),
              let map = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any] else {
            self.parameter = [:]
            return
        }
        self.parameter = map
    }
    
    
    /// 将模块化的参数转换为我们需要的模型
    /// - Returns: 需要的模型
    public func toModel<T:Codable>() -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed),
              let model = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return model
    }
    
    /// 通过Key值获取对应的参数
    subscript<T>(key:String) -> T? {
        guard let value = parameter[key] as? T else {
            return nil
        }
        return value
    }
    
    subscript<T>(key:String, defaultValue:T) -> T {
        return self[key] ?? defaultValue
    }
    
    public func toJSON() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed),
              let jsonText = String(data: data, encoding: .utf8) else {
            return nil
        }
        return jsonText
    }
}
