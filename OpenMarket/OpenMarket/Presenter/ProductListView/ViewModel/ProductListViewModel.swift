//
//  ProductListViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductListViewModelable {
  var productListObservable: BehaviorRelay<[BasicProductEntity]> { get set }
  var delegate: ProductListViewModelDelegate? { get set }
  func updateList()
  func action(action: ProductListViewModel.ViewAction)
}

protocol ProductListViewModelDelegate: AnyObject {
  func coordinatorShowProductView(productID: Int)
}

final class ProductListViewModel: ProductListViewModelable {
  weak var delegate: ProductListViewModelDelegate?
  private let disposeBag: DisposeBag
  private let fetchUseCase: FetchUseCaseable
  var productListObservable: BehaviorRelay<[BasicProductEntity]>
  
  init(fetchUseCase: FetchUseCaseable) {
    self.fetchUseCase = fetchUseCase
    self.disposeBag = .init()
    self.productListObservable = .init(value: [])
    
    updateList()
  }
  
  func action(action: ViewAction) {
    switch action {
    case let .productTap(productID):
      delegate?.coordinatorShowProductView(productID: productID)
    case .updataList:
      updateList()
    }
  }
  
  func updateList() {
    fetchUseCase.fetchProductList(pageNum: 1)
      .compactMap { $0.product }
      .map { $0.map { $0.toEneity()} }
      .bind(to: productListObservable)
      .disposed(by: disposeBag)
  }
}

// MARK: - Action

extension ProductListViewModel {
  enum ViewAction {
    case productTap(Int)
    case updataList
  }
}
