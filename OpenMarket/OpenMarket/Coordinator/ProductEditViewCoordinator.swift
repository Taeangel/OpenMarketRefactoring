//
//  ProductEditViewCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit

class ProductEditViewCoordinator: Coordinator {
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

  func makeProductEditViewController() -> UIViewController {
    let productEditViewController = openMarketDIContainer.makeProductEditViewController()
    productEditViewController.coordinator = self
    return productEditViewController
  }
  
  func showProductModifyViewController(_ productID: Int) {
    guard let navigationController = navigationController else { return }
    let productViewCoordinator =
    openMarketDIContainer.makeProductModifyViewCoordinator(navigationController: navigationController)
    
    childCoordinators.append(productViewCoordinator)
    productViewCoordinator.parentCoordinator = self
    
    productViewCoordinator.start(productID)
  }
}
