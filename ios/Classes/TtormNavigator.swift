//
//  TtormNavigator.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 负责路由跳转
public class TtormNavigator {
    public static func push(_ identifier:TtormIdentifier,
                            _ parameter:TtormParameter,
                            _ animated:Bool,
                            _ custom:((UIViewController) -> Void)? = nil) {
        guard let controller = Ttorm.manager.register.getController(identifier, parameter) else {
            return
        }
        if let custom = custom {
            custom(controller)
        } else {
            let navigationController = TtormTopViewController.topViewController()?.navigationController
            navigationController?.pushViewController(controller, animated: animated)
        }
    }

}
