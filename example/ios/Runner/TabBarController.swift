//
//  TabBarController.swift
//  Runner
//
//  Created by 张行 on 2021/3/13.
//

import UIKit
import ttorm

class TabBarController: UITabBarController, TtormModule {
    static func ttormMakeController(parameter: TtormParameter) -> UIViewController? {
        return TabBarController()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(createViewController(title: "FlutterA", identifier: "APage", parameter: TtormParameter(["name":"Hello Joser"])))
        self.addChild(createViewController(title: "FlutterB", identifier: "BPage"))
        self.addChild(createViewController(title: "FlutterA", identifier: "APage"))
        self.addChild(createViewController(title: "NativeB", identifier: "BViewController"))
        
    }
    
    func createViewController(title:String, identifier:String, parameter:TtormParameter? = nil) -> UIViewController {
        let controller = Ttorm.manager.register.getController(TtormIdentifier(identifier), parameter ?? TtormParameter()) ?? UIViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem.title = title
        navigationController.isNavigationBarHidden = true
        return navigationController
        
    }
    
}
