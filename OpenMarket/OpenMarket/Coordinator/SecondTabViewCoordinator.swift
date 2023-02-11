//
//  SecondTabViewCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class SecondTabViewCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() -> UIViewController {
    let secondTabViewController = SecondTabViewController()
    secondTabViewController.coordinator = self
    return secondTabViewController
  }
}
