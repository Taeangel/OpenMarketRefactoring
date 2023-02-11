//
//  FirstTabViewCoordinator.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class FirstTabViewCoordinator: Coordinator {
  weak var navigationController: UINavigationController?
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() -> UIViewController {
    let firstTabViewController = FirstTabViewController()
    firstTabViewController.coodinator = self
    return firstTabViewController
  }
  
}
