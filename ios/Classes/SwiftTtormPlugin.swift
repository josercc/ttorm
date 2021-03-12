import Flutter
import UIKit

public class SwiftTtormPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "Ttorm", binaryMessenger: registrar.messenger())
        let plugin = SwiftTtormPlugin()
        registrar.addMethodCallDelegate(plugin, channel: methodChannel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("handle")
    }
    
}

