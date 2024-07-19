import Flutter
import UIKit

class SwiftLoginPlugin: NSObject, FlutterPlugin {
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "login_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftLoginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        NotificationCenter.default.addObserver(instance, selector: #selector(instance.handleDataListFetched(notification:)), name: NSNotification.Name("dataListFetched"), object: nil)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "showLogin" {
            showLoginScreen(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func showLoginScreen(result: @escaping FlutterResult) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            result(FlutterError(code: "UNAVAILABLE", message: "Root view controller unavailable", details: nil))
            return
        }

        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.onLoginSuccess = {
            result(nil) // Gửi thông tin đăng nhập về Flutter nếu cần thiết
        }

        viewController.present(loginViewController, animated: true, completion: nil)
    }

    @objc private func handleDataListFetched(notification: Notification) {
        guard let dataList = notification.userInfo?["dataList"] as? [String] else { return }
        let channel = FlutterMethodChannel(name: "login_plugin", binaryMessenger: UIApplication.shared.keyWindow!.rootViewController as! FlutterBinaryMessenger)
        channel.invokeMethod("onDataListFetched", arguments: dataList)
    }
}
