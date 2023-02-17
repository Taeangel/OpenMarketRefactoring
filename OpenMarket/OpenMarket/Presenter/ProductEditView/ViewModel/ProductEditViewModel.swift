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
  func updateList()
  func deleteProduct(id: Int)
  var myProductListObservable: BehaviorRelay<[BasicProductEntity]> { get set }
}

final class ProductEditViewModel: ProductEditViewModelable {
  
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
  
  func updateList() {
    fetchUseCase.fetchMyProductList()
      .compactMap { $0.product }
      .bind(to: myProductListObservable)
      .disposed(by: disposeBag)
  }
  
  func deleteProduct(id: Int) {
    editUseCase.deleteProduct(id: id)
      .flatMap { self.fetchUseCase.fetchMyProductList()
}
      .compactMap { $0.product }
      .bind(to: myProductListObservable)
      .disposed(by: disposeBag)
  }
}

