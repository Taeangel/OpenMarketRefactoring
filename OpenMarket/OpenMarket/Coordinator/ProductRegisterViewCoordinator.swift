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
  var childCoordinators: [Coordinator] = []
  
  private let openMarketDIContainer: OpenMarketDIContainer
  
  init(
    navigationController: UINavigationController,
    openMarketDIContainer: OpenMarketDIContainer
  ) {
    self.navigationController = navigationController
    self.openMarketDIContainer = openMarketDIContainer
  }

  func start() -> UIViewController {
    let secondTabViewController = openMarketDIContainer.makeProductRegisterViewController()
    secondTabViewController.coordinator = self
    return secondTabViewController
  }
}
