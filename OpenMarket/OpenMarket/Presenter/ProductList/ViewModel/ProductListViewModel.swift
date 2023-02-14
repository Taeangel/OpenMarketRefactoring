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
  func bind()
  var productListObservable: BehaviorRelay<[Product]> { get set }
}

final class ProductListViewModel: ProductListViewModelable {
  private let disposeBag: DisposeBag
  private let fetchUseCase: FetchUseCaseable
  var productListObservable: BehaviorRelay<[Product]>
  
  init(fetchUseCase: FetchUseCaseable) {
    self.fetchUseCase = fetchUseCase
    self.disposeBag = .init()
    self.productListObservable = .init(value: [])
    
    bind()
  }
  
  func bind() {
    fetchUseCase.fetchProductList()
      .compactMap { $0.product }
      .bind(to: productListObservable)
      .disposed(by: disposeBag)
  }
}
