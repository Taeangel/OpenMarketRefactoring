//
//  ProductCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit

final class ProductViewCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator]
  
  private let dependencyContainer: OpenMarketDIContainer
  
  init(
    navigationController: UINavigationController,
    dependencyContainer: OpenMarketDIContainer
  ) {
    self.dependencyContainer = dependencyContainer
    self.navigationController = navigationController
    self.childCoordinators = .init()
  }
 
  func start(_ product: ProductEntity) {
    let productViewController = dependencyContainer.makeProductViewController(product)
    productViewController.coordinator = self
    
    navigationController?.pushViewController(productViewController, animated: true)
  }
  
  func dismiss() {
    navigationController?.dismiss(animated: true)
    parentCoordinator?.removeChild(self)
  }
}
