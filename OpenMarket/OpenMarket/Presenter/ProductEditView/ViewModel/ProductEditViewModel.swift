//
//  ProductEditViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductEditViewModelable {
  var myProductListObservable: BehaviorRelay<[BasicProductEntity]> { get set }
  var delegate: ProductEditViewModelDelegate? { get set }
  
  func action(action: ProductEditViewModel.ViewAction)
}

protocol ProductEditViewModelDelegate: AnyObject {
  func coordinatorShowModifyView(_ productID: Int)
}

final class ProductEditViewModel: ProductEditViewModelable {
  weak var delegate: ProductEditViewModelDelegate?
  var myProductListObservable: BehaviorRelay<[BasicProductEntity]>
  private var disposeBag: DisposeBag
  private let fetchUseCase: FetchUseCaseable
  private let editUseCase: EditUseCaseable
  
  init(
    fetchUseCase: FetchUseCaseable,
    editUseCase: EditUseCaseable
  ) {
    self.disposeBag = .init()
    self.fetchUseCase = fetchUseCase
    self.editUseCase = editUseCase
    self.myProductListObservable = .init(value: [])
    
    updateList()
  }
  
  func action(action: ViewAction) {
    switch action {
    case let .ModifyProductButtonTap(productID):
      delegate?.coordinatorShowModifyView(productID)
    case let .deleteProductButtonTap(productID):
      deleteProduct(id: productID)
    case .updateList:
      updateList()
    }
  }
  
  private func updateList() {
    fetchUseCase.fetchMyProductList()
      .compactMap { $0.product }
      .map { $0.map { $0.toEneity()} }
      .bind(to: myProductListObservable)
      .disposed(by: disposeBag)
  }
  
  private func deleteProduct(id: Int) {
    editUseCase.deleteProduct(id: id)
      .flatMap { self.fetchUseCase.fetchMyProductList() }
      .compactMap { $0.product }
      .map { $0.map { $0.toEneity()} }
      .bind(to: myProductListObservable)
      .disposed(by: disposeBag)
  }
}

extension ProductEditViewModel {
  enum ViewAction {
    case deleteProductButtonTap(Int)
    case ModifyProductButtonTap(Int)
    case updateList
  }
}
