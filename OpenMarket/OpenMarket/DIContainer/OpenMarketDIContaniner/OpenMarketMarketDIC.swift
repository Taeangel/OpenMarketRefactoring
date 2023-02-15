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
    let editStorage: EditStorage
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
    return ProductListViewCoordinator(
      navigationController: navigationController,
      openMarketDIContainer: self
    )
  }
  
  private func makeProductLostViewModel() -> ProductListViewModel {
    return ProductListViewModel(fetchUseCase: makefetchUseCase())
  }
  
  func makeProductListViewController() -> ProductListViewController {
    return ProductListViewController(viewModel: makeProductLostViewModel())
  }
  
  // MARK: - ProductRegister
  
  func makeProductRegisterViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductRegisterViewCoordinator {
    return ProductRegisterViewCoordinator(
      navigationController: navigationController,
      openMarketDIContainer: self
    )
  }
  
  private func makeProductRegisterViewModel() -> ProductRegisterViewModelable {
    return ProductRegisterViewModel(registerUseCase: makeRegisterUseCase())
  }
  
  func makeProductRegisterViewController() -> ProductRegisterViewController {
    return ProductRegisterViewController(viewModel: makeProductRegisterViewModel())
  }
  
  
  // MARK: - Repository
  private func makeRegisterRepository() -> RegisterRepositoriable {
    return RegisterRepository(registerStorageable: dependencies.registerStorage)
  }
  
  private func makeFetchRepository() -> FetchRepositorible {
    return FetchRepository(fetchStorageable: dependencies.fetchStorage)
  }
  
  private func makeEditRepository() -> EditRepositoriable {
    return EditRepository(editStorageable: dependencies.editStorage)
  }
  
  // MARK: - UseCase
  
  private func makeRegisterUseCase() -> RegisterUseCase {
    return RegisterUseCase(registerRepository: makeRegisterRepository())
  }
  
  private func makefetchUseCase() -> FetchUseCaseable {
    return FetchUseCase(fetchRepository: makeFetchRepository())
  }
  
  private func makeEditUseCase() -> EditUseCaseable {
    return EditUseCase(editRepository: makeEditRepository())
  }
}
