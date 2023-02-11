import UIKit

class AppCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {

    guard let navigationController = navigationController else { return }

    let mainCoordinator = MainViewCoordinator(navigationController: navigationController)
    
    childCoordinators.append(mainCoordinator)
    mainCoordinator.parentCoordinator = self
    mainCoordinator.start()
  }
}
