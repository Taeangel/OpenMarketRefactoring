//
//  OpenMarketMarket.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import UIKit

final class OpenMarketDIContainer {
  
  struct Dependencies {
    let openMarketStorage: OpenMarketStorage
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
}

extension OpenMarketDIContainer {
  
  // MARK: - ProductList
  func makeProductListViewController() -> ProductListViewController {
    return ProductListViewController()
  }
  
  // MARK: - ProductRegisterView
  
  func makeProductRegisterViewController() -> ProductRegisterViewController {
    return ProductRegisterViewController()
  }
   
  // MARK: - Repository
  
  private func makeOpenMarketRepository() -> OpenMarketRepositorible {
    return OpenMarketRepository(openMarketStorageable: dependencies.openMarketStorage)
  }
  
  // MARK: - UseCase
  
  func makeOpenMarketUseCase() -> OpenMarketUseCaseable {
    return OpenMarketUseCase(openMarketRepository: makeOpenMarketRepository())
  }
  
  // MARK: - Coordiantor
   
  func makeProductListViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductListViewCoordinator {
    return ProductListViewCoordinator(navigationController: navigationController)
  }
  
  func makeProductRegisterViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductRegisterViewCoordinator {
    return ProductRegisterViewCoordinator(navigationController: navigationController)
  }
}
