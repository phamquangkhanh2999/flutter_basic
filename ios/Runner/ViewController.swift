import UIKit
import Flutter

class LoginViewController12: UIViewController {
  
  let usernameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Username"
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = true
    return textField
  }()
  
  var flutterEngine: FlutterEngine?
  var flutterViewController: FlutterViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
      usernameTextField.widthAnchor.constraint(equalToConstant: 200),
      passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
      passwordTextField.widthAnchor.constraint(equalToConstant: 200)
    ])
    
    // Khởi tạo Flutter engine
    flutterEngine = FlutterEngine(name: "my flutter engine")
    flutterEngine?.run()
    
    // Kiểm tra và unwrap flutterEngine an toàn
    guard let flutterEngine = flutterEngine else {
      print("Failed to initialize FlutterEngine")
      return
    }
    
    // Khởi tạo FlutterViewController
    flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    
    // Thiết lập MethodChannel để nhận cuộc gọi từ Flutter
    let loginChannel = FlutterMethodChannel(name: "com.example/login", binaryMessenger: flutterViewController!.binaryMessenger)
    loginChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "login" {
        guard let args = call.arguments as? [String: Any],
              let username = args["username"] as? String,
              let password = args["password"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
          return
        }
        // Xử lý logic đăng nhập
        self?.handleLogin(username: username, password: password, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    // Thêm FlutterViewController vào view hierarchy
    addChild(flutterViewController!)
    flutterViewController!.view.frame = view.bounds
    flutterViewController!.view.backgroundColor = .clear
    view.addSubview(flutterViewController!.view)
    flutterViewController!.didMove(toParent: self)
  }
  
  private func handleLogin(username: String, password: String, result: @escaping FlutterResult) {
    // Thực hiện logic đăng nhập và trả về kết quả
    if username == "admin" && password == "admin" {
      result("Login successful")
      navigateToHome(username: username)
    } else {
      result("Login failed")
    }
  }
  
  private func navigateToHome(username: String) {
//    let homeViewController = HomeViewController()
//    homeViewController.username = username
//    navigationController?.pushViewController(homeViewController, animated: true)
  }
}
