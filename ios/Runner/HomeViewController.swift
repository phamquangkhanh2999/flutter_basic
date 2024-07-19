import UIKit

class HomeViewController: UIViewController {
    var onDataSend: (([String]) -> Void)?

    private let dataList: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    private let sendDataButton = UIButton(type: .system)
    private let goBackButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        // Thiết lập và thêm nút "Send Data"
        sendDataButton.setTitle("Send Data ahihi", for: .normal)
        sendDataButton.frame = CGRect(x: 20, y: 200, width: self.view.frame.width - 40, height: 50)
        sendDataButton.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
        self.view.addSubview(sendDataButton)

        // Thiết lập và thêm nút "Go Back"
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.frame = CGRect(x: 20, y: 270, width: self.view.frame.width - 40, height: 50)
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        self.view.addSubview(goBackButton)
    }

    @objc func sendDataButtonTapped() {
        // Gửi dữ liệu về Flutter
        onDataSend?(dataList)
        
        // Đóng tất cả các màn hình Native để quay về Flutter
        if let presentingViewController = self.presentingViewController {
            presentingViewController.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func goBackButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
