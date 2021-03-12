//
//  Ttorm.swift
//  ttorm
//
//  Created by 张行 on 2021/3/11.
//

import Foundation

public class Ttorm {
    public static let manager = Ttorm()
    public let register:TtormRegister
    
    public var ttormChannel:FlutterMethodChannel? {
        didSet {
//            ttormChannel?.setMethodCallHandler({ (call, result) in
//                if call.method == "getValue" {
//                    if let arguments = call.arguments as? String {
//                        let parameter = TtormParameter(arguments)
//                        if let key:String = parameter["key"]  {
//                            result(UserDefaults.standard.object(forKey: key))
//                        } else {
//                            result(nil)
//                        }
//                    } else {
//                        result(nil)
//                    }
//                } else {
//                    result(FlutterMethodNotImplemented)
//                }
//            })
        }
    }
    
    private init() {
        self.register = TtormRegister()
    }
    
    public func initRoute(_ registerHandle:@escaping((TtormRegister) -> Void)) {
        registerHandle(self.register)
    }
    
    public func runApp(root:TtormIdentifier, parameter:TtormParameter = TtormParameter(), handle:((UIViewController) -> Void)) {
        guard let rootController = register.getController(root, parameter) else {
            assert(false,"\(root.identifier)没有注册")
        }
        handle(rootController)
    }
}
