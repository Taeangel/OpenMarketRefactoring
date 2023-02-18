//
//  ProductModifyCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import Foundation

import UIKit

final class ProductModifyCoordinator: Coordinator {
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
 
  func start(_ productID: Int) {
    let productViewController = dependencyContainer.makeProductModifyViewController(productID)
    productViewController.coordinator = self
    navigationController?.pushViewController(productViewController, animated: true)
  }
  
  func dismiss() {
    navigationController?.popViewController(animated: true)
    parentCoordinator?.removeChild(self)
  }
}
