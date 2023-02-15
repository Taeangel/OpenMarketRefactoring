//
//  SecondTabViewCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class ProductRegisterViewCoordinator: Coordinator {
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

  func makeProductRegisterViewController() -> UIViewController {
    let productRegisterViewController = openMarketDIContainer.makeProductRegisterViewController()
    productRegisterViewController.coordinator = self
    return productRegisterViewController
  }
}
