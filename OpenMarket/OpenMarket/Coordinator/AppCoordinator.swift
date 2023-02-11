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
    
    let tabBarView = UITabBarController()
    
    let firstTabViewCoordinator = FirstTabViewCoordinator(navigationController: navigationController)
    let secondTabViewCoordinator = SecondTabViewCoordinator(navigationController: navigationController)
    
    childCoordinators.append(firstTabViewCoordinator)
    childCoordinators.append(secondTabViewCoordinator)
    
    firstTabViewCoordinator.parentCoordinator = self
    secondTabViewCoordinator.parentCoordinator = self
    
    let firstTabView = firstTabViewCoordinator.start()
    let secondTabView = secondTabViewCoordinator.start()
    
    firstTabView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 0)
    secondTabView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)
    
    tabBarView.setViewControllers([firstTabView, secondTabView], animated: true)
    
    self.navigationController?.pushViewController(tabBarView, animated: true)
  }
}
