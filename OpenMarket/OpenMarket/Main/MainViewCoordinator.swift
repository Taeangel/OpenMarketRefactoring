import UIKit

class MainViewCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let mainViewController = MainViewController()
    mainViewController.coordinator = self
    self.navigationController?.pushViewController(mainViewController, animated: true)
  }
}
