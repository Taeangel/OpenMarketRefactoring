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
    
    let productEditViewCoordinator = openMarketDIContainer.makeProductEditViewCoordinator(
      navigationController: navigationController
    )
    
    childCoordinators.append(productListViewCoordinator)
    childCoordinators.append(productRegisterViewCoordinator)
    childCoordinators.append(productEditViewCoordinator)
    
    productListViewCoordinator.parentCoordinator = self
    productRegisterViewCoordinator.parentCoordinator = self
    productEditViewCoordinator.parentCoordinator = self
    
    let productListView = productListViewCoordinator.makeProductListViewController()
    let productRegisterView = productRegisterViewCoordinator.makeProductRegisterViewController()
    let productEditView = productEditViewCoordinator.makeProductEditViewController()
    
    productListView.tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "house.circle"),
      tag: 0
    )
    productRegisterView.tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "plus.app.fill"),
      tag: 1
    )
    
    productEditView.tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "person.fill"),
      tag: 2
    )
    
    tabBarView.setViewControllers([productListView, productRegisterView, productEditView], animated: true)
    self.navigationController?.pushViewController(tabBarView, animated: true)
  }
}
