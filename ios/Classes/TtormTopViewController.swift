//
//  TtormTopViewController.swift
//  ttorm
//
//  Created by 张行 on 2021/3/8.
//

import UIKit

class TtormTopViewController {
    private static var currentWindow:UIWindow? {
        let windows = UIApplication.shared.windows
        for window in windows {
            if let _ = window.rootViewController,
               window.bounds.size == UIScreen.main.bounds.size {
                return window
            }
        }
        return nil
    }
    
    static func topViewController(_ controller:UIViewController? = nil) -> UIViewController? {
        let rootViewController:UIViewController
        if let rootController = controller {
            rootViewController = rootController
        } else {
            guard let window = self.currentWindow, let windowRootController = window.rootViewController else {
                return nil
            }
            rootViewController = windowRootController
        }
        if let navigationController = rootViewController as? UINavigationController {
            return topViewController(navigationController)
        } else if let tabbarController = rootViewController as? UITabBarController {
            return topViewController(tabbarController)
        } else {
            return rootViewController
        }
    }
    
    static func topViewController(_ navigationController:UINavigationController) ->UIViewController? {
        if let navigationTopController = navigationController.topViewController {
            return topViewController(navigationTopController)
        } else {
            return navigationController.viewControllers.last
        }
    }
    
    static func topViewController(_ tabbarController:UITabBarController) ->UIViewController? {
        if let navigationController = tabbarController.selectedViewController as? UINavigationController {
            return topViewController(navigationController)
        } else {
            return tabbarController.selectedViewController
        }
    }
}
