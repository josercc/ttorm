import UIKit
import Flutter
import ttorm

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    
    Ttorm.manager.initRoute { (register) in
        register.register(AViewController.self)
        register.register(BViewController.self)
    }
    Ttorm.manager.runApp(root: TtormIdentifier("APage")) { (root) in
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.rootViewController = root
        self.window.makeKeyAndVisible()
    }
    

    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
