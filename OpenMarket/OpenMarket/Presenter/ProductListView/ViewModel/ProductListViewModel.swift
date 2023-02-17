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
  func updateList()
  var productListObservable: BehaviorRelay<[BasicProductEntity]> { get set }
}

final class ProductListViewModel: ProductListViewModelable {
  private let disposeBag: DisposeBag
  private let fetchUseCase: FetchUseCaseable
  var productListObservable: BehaviorRelay<[BasicProductEntity]>
  
  init(fetchUseCase: FetchUseCaseable) {
    self.fetchUseCase = fetchUseCase
    self.disposeBag = .init()
    self.productListObservable = .init(value: [])
    
    updateList()
  }
  
  func updateList() {
    fetchUseCase.fetchProductList(pageNum: 1)
      .compactMap { $0.product }
      .bind(to: productListObservable)
      .disposed(by: disposeBag)
  }
}
