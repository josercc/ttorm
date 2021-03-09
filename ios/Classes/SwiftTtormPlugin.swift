import Flutter
import UIKit

public class SwiftTtormPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        ttormMethodChannel = FlutterMethodChannel(name: "ttorm", binaryMessenger: registrar.messenger())
        let instance = SwiftTtormPlugin()
        registrar.addMethodCallDelegate(instance, channel: ttormMethodChannel!)
    }
    /// Ttorm框架的主方法通道
    public static var ttormMethodChannel:FlutterMethodChannel?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == TtormMethodName.getAllRegisterIdentifiers.rawValue {
            let identifiers = TtormRegister.allRegisterIdentifiers
            result(identifiers)
        }
    }
}

