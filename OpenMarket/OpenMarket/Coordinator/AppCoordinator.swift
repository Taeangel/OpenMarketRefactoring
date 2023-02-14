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
    
    let productListViewCoordinator = ProductListViewCoordinator(navigationController: navigationController)
    let productRegisterViewCoordinator = ProductRegisterViewCoordinator(navigationController: navigationController)
    
    childCoordinators.append(productListViewCoordinator)
    childCoordinators.append(productRegisterViewCoordinator)
    
    productListViewCoordinator.parentCoordinator = self
    productRegisterViewCoordinator.parentCoordinator = self
    
    let productListView = productListViewCoordinator.start()
    let productRegisterView = productRegisterViewCoordinator.start()
    
    productListView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 0)
    productRegisterView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)
    
    tabBarView.setViewControllers([productListView, productRegisterView], animated: true)
    
    self.navigationController?.pushViewController(tabBarView, animated: true)
  }
}
