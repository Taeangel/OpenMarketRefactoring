//
//  FirstTabViewCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class ProductListViewCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator]
  
  private let openMarketDIContainer: OpenMarketDIContainer
  
  init(
    navigationController: UINavigationController,
    openMarketDIContainer: OpenMarketDIContainer
  ) {
    self.childCoordinators = .init()
    self.navigationController = navigationController
    self.openMarketDIContainer = openMarketDIContainer
  }
  
  func makeProductListViewController() -> UIViewController {
    let productListViewController = openMarketDIContainer.makeProductListViewController()
    productListViewController.coordinator = self
    return productListViewController
  }
  
  func showProductViewController(_ productID: Int) {
    guard let navigationController = navigationController else { return }
    let productViewCoordinator =
    openMarketDIContainer.makeProductViewCoordinator(navigationController: navigationController)
    
    childCoordinators.append(productViewCoordinator)
    productViewCoordinator.parentCoordinator = self
    
    productViewCoordinator.start(productID)
  }
}
