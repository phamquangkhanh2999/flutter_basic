import UIKit

class LoginViewController: UIViewController {
    var onLoginSuccess: (() -> Void)?

    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let goBackButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        // Thiết lập và thêm ô nhập liệu tên người dùng
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Username"
        usernameTextField.frame = CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 40)
        self.view.addSubview(usernameTextField)

        // Thiết lập và thêm ô nhập liệu mật khẩu
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 40)
        self.view.addSubview(passwordTextField)

        // Thiết lập và thêm nút "Login"
        loginButton.setTitle("Login", for: .normal)
        loginButton.frame = CGRect(x: 20, y: 200, width: self.view.frame.width - 40, height: 50)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.view.addSubview(loginButton)

        // Thiết lập và thêm nút "Go Back"
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.frame = CGRect(x: 20, y: 270, width: self.view.frame.width - 40, height: 50)
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        self.view.addSubview(goBackButton)
    }

    @objc func loginButtonTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        // Điều hướng đến màn hình Home
        let homeViewController = HomeViewController()
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.onDataSend = { dataList in
            // Gửi danh sách về Flutter
            NotificationCenter.default.post(name: NSNotification.Name("dataListFetched"), object: nil, userInfo: ["dataList": dataList])
        }
        self.present(homeViewController, animated: true, completion: nil)
    }

    @objc func goBackButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
