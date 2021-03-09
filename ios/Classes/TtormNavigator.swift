//
//  TtormNavigator.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import Foundation
/// 负责路由跳转
public class TtormNavigator {
    public static func push(_ identifier:String,
                            _ parameter:TtormParameter,
                            _ animated:Bool) {
        getController(identifier, parameter) { (controller) in
            let navigationController = TtormTopViewController.topViewController()?.navigationController
            navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    static public func getController(_ identifier:String,
                                     _ parameter:TtormParameter,
                                     handle:@escaping((UIViewController) -> Void)) {
        if let controller = TtormRegister.getController(identifier, parameter) {
            handle(controller)
        } else {
            guard let channel = SwiftTtormPlugin.ttormMethodChannel else {
                assert(false,"SwiftTtormPlugin.ttormMethodChannel It didn't come true")
                return
            }
            channel.invokeMethod(TtormMethodName.getAllRegisterIdentifiers.rawValue, arguments: nil) { result in
                guard let identifiers = result as? [String] else {
                    assert(false,"TtormMethodName.getAllRegisterIdentifiers Return value is not [string]")
                    return
                }
                guard identifiers.contains(identifier) else {
                    assert(false,"\(identifier)的模块没有实现")
                    return
                }
                let arguments:[String:Any] = [
                    "identifier":identifier,
                    "parameter":parameter.parameter
                ]
                /// 提前发送需要初始化的界面
                channel.invokeMethod(TtormMethodName.runFlutterView.rawValue, arguments: TtormParameter(arguments).toJSON()) { result in
                    let engine = ttormFlutterEngineGroup.makeEngine(withEntrypoint: ttormRunEngine,
                                                                    libraryURI: nil)
                    let flutterController = FlutterViewController(engine: engine,
                                                                  nibName: nil,
                                                                  bundle: nil)
                    handle(flutterController)
                    
                }
                
            }
        }
    }

}
