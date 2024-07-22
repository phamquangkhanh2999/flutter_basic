import UIKit

class Screen5ViewController: UIViewController {
    var onDataSend: (([String]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let sendDataButton = UIButton(type: .system)
        sendDataButton.setTitle("Send Data", for: .normal)
        sendDataButton.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
        sendDataButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)

        self.view.addSubview(sendDataButton)
    }

    @objc func sendDataButtonTapped() {
        let data = ["Sample data 1", "Sample data 2"]
        onDataSend?(data)
    }
}
