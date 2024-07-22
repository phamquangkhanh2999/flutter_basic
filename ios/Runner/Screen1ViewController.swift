import UIKit

class Screen1ViewController: UIViewController {
    var onNext: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)

        self.view.addSubview(nextButton)
    }

    @objc func nextButtonTapped() {
        onNext?()
    }
}
