import UIKit

class AppCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator]

  private let appDIContainer: AppDIContainer
  
  init(
    navigationController: UINavigationController,
    appDIContainer: AppDIContainer
  ) {
    self.childCoordinators = .init()
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
  }

  func start() {

    guard let navigationController = navigationController else { return }
    
    let tabBarView = UITabBarController()
    
    let openMarketDIContainer = appDIContainer.makeOpenMarketDIContainer()
    
    let productListViewCoordinator = openMarketDIContainer.makeProductListViewCoordinator(
      navigationController: navigationController
    )
    let productRegisterViewCoordinator = openMarketDIContainer.makeProductRegisterViewCoordinator(
      navigationController: navigationController
    )
    
    childCoordinators.append(productListViewCoordinator)
    childCoordinators.append(productRegisterViewCoordinator)
    
    productListViewCoordinator.parentCoordinator = self
    productRegisterViewCoordinator.parentCoordinator = self
    
    let productListView = productListViewCoordinator.makeProductListViewController()
    let productRegisterView = productRegisterViewCoordinator.makeProductRegisterViewController()
    
    productListView.tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "heart"),
      tag: 0
    )
    productRegisterView.tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "heart"),
      tag: 1
    )
    
    tabBarView.setViewControllers([productListView, productRegisterView], animated: true)
    
    self.navigationController?.pushViewController(tabBarView, animated: true)
  }
}
