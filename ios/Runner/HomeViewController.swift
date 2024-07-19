import UIKit

class HomeViewController: UIViewController {
  
  var username: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    let welcomeLabel = UILabel()
    welcomeLabel.text = "Welcome, \(username ?? "User")!"
    welcomeLabel.textAlignment = .center
    
    view.addSubview(welcomeLabel)
    welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
