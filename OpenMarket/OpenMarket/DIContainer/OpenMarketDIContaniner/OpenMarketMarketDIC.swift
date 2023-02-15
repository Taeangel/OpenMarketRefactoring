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
  
  // MARK: - ProductEdit
 
  func makeProductEditViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductEditViewCoordinator {
    return ProductEditViewCoordinator(
      navigationController: navigationController,
      openMarketDIContainer: self
    )
  }
 
  func makeProductEditViewController() -> ProductEditViewController {
    return ProductEditViewController(viewModel: makeProductEditViewModel())
  }
  
  private func makeProductEditViewModel() -> ProductEditViewModelable {
    return ProductEditViewModel(fetchUseCase: makefetchUseCase(), editUseCase: makeEditUseCase())
  }
  
  // MARK: - Product
  
  func makeProductViewCoordinator(
    navigationController: UINavigationController
  ) -> ProductViewCoordinator {
    return ProductViewCoordinator(
      navigationController: navigationController,
      dependencyContainer: self
    )
  }
  
  private func makeProductViewModel(_ product: ProductEntity) -> ProductViewModel {
    return ProductViewModel(product: product, fetchUseCase: makefetchUseCase())
  }
  
  func makeProductViewController(_ product: ProductEntity) -> ProductViewController {
    return ProductViewController(viewModel: makeProductViewModel(product))
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
