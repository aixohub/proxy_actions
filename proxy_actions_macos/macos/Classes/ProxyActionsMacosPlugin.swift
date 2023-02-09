import Cocoa
import FlutterMacOS


public class ProxyActionsMacosPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {

        let channel = FlutterMethodChannel(name: "plugins.flutter.io/proxy_actions_macos", binaryMessenger: registrar.messenger)
        let instance = ProxyActionsMacosPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
       
    }
    
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
        case "setShortcutItems":
            result(nil)
        case "clearShortcutItems":
            result(nil)
        case "getLaunchAction":
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
