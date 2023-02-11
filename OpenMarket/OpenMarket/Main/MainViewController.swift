import UIKit

class MainViewController: UITabBarController {
  weak var coordinator: MainViewCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
}
