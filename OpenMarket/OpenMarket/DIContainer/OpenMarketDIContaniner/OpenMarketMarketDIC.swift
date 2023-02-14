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
    let fetchStorage: FetchStorage
    let registerStorage: RegisterStorage
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
}

extension OpenMarketDIContainer {
  
  // MARK: - ProductList
  
  func makeProductListViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductListViewCoordinator {
    return ProductListViewCoordinator(navigationController: navigationController)
  }
  
  func makeProductListViewController() -> ProductListViewController {
    return ProductListViewController()
  }
  
  // MARK: - ProductRegisterView
  
  func makeProductRegisterViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductRegisterViewCoordinator {
    return ProductRegisterViewCoordinator(navigationController: navigationController)
  }
  
  func makeProductRegisterViewController() -> ProductRegisterViewController {
    return ProductRegisterViewController()
  }
   
  // MARK: - Repository
  
  private func makeFetchRepository() -> FetchRepositorible {
    return FetchRepository(openMarketStorageable: dependencies.fetchStorage)
  }
  
  private func makeRegisterRepository() -> RegisterRepositoriable {
    return RegisterRepository(registerStorageable: dependencies.registerStorage)
  }
  
  // MARK: - UseCase
  
  func makeOpenMarketUseCase() -> FetchUseCaseable {
    return FetchUseCase(fetchRepository: makeFetchRepository())
  }
  
  func makeRegisterUseCase() -> RegisterUseCase {
    return RegisterUseCase(registerRepository: makeRegisterRepository())
  }
}
