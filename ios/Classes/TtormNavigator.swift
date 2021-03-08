//
//  TtormNavigator.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 负责路由跳转
public class TtormNavigator {
    public static func push(_ identifier:String, _ parameter:TtormParameter, animation:Bool, isFromFlutter:Bool = false) {
        if let controller = TtormRegister.getController(identifier, parameter) {
            let navigationController = TtormTopViewController.topViewController()?.navigationController
            navigationController?.pushViewController(controller, animated: animation)
        } else {
            if isFromFlutter {
                assert(false,"\(identifier)的模块没有实现")
            } else {
                
            }
        }
    }
    
    
}
