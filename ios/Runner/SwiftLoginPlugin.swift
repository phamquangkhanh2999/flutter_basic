import Flutter
import UIKit

class SwiftLoginPlugin: NSObject, FlutterPlugin {
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "login_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftLoginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
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
        loginViewController.onLoginSuccess = { username, password in
            // Gửi thông tin người dùng về Flutter
            result(["username": username, "password": password])
        }

        viewController.present(loginViewController, animated: true, completion: nil)
    }
}
