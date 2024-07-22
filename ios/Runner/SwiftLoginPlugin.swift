import Flutter
import UIKit

public class SwiftLoginPlugin: NSObject, FlutterPlugin {
    private var flutterResult: FlutterResult?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "login_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftLoginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "showLogin" {
            flutterResult = result
            showLoginScreen()
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func showLoginScreen() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }

        // Tìm view controller hiện tại đang hiển thị
        var topController = rootViewController
        while let presentedVC = topController.presentedViewController {
            topController = presentedVC
        }

        let screen1VC = Screen1ViewController()
        screen1VC.modalPresentationStyle = .fullScreen
        screen1VC.onNext = {
            self.presentNextViewController(from: screen1VC, nextViewController: Screen2ViewController())
        }

        DispatchQueue.main.async {
            topController.present(screen1VC, animated: true, completion: nil)
        }
    }

    private func presentNextViewController(from currentViewController: UIViewController, nextViewController: UIViewController) {
        if let screen = nextViewController as? Screen2ViewController {
            screen.onNext = {
                self.presentNextViewController(from: screen, nextViewController: Screen3ViewController())
            }
        } else if let screen = nextViewController as? Screen3ViewController {
            screen.onNext = {
                self.presentNextViewController(from: screen, nextViewController: Screen4ViewController())
            }
        } else if let screen = nextViewController as? Screen4ViewController {
            screen.onNext = {
                self.presentNextViewController(from: screen, nextViewController: Screen5ViewController())
            }
        } else if let screen = nextViewController as? Screen5ViewController {
            screen.onDataSend = { data in
                self.sendDataToFlutter(data)
                self.dismissAllViewControllers(currentViewController)
            }
        }
        
        nextViewController.modalPresentationStyle = .fullScreen
        currentViewController.present(nextViewController, animated: true, completion: nil)
    }

    private func dismissAllViewControllers(_ viewController: UIViewController) {
        var vc = viewController
        while let presentingVC = vc.presentingViewController {
            vc = presentingVC
        }
        vc.dismiss(animated: true, completion: nil)
    }

    private func sendDataToFlutter(_ data: [String]) {
        flutterResult?(data)
    }
}
