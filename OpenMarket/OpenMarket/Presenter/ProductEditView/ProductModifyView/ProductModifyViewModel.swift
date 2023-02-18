//
//  ModifyViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductModifyViewModelable {
  var productId: Int { get }
  var productObservable: BehaviorRelay<DetailProductEneity> { get set }
  func modiftProduct(product: ProductRequestDTO)
}

class ProductModifyViewModel: ProductModifyViewModelable {
  var productId: Int
  private var disposeBag: DisposeBag
  var productObservable: BehaviorRelay<DetailProductEneity>
  private let fetchUseCase: FetchUseCaseable
  private let editUseCase: EditUseCaseable
  
  init(
    productId: Int,
    fetchUseCase: FetchUseCaseable,
    editUseCase: EditUseCaseable
  ) {
    self.productId = productId
    self.fetchUseCase = fetchUseCase
    self.editUseCase = editUseCase
    self.productObservable = .init(value: DetailProductEneity())
    self.disposeBag = .init()
    
    bind()
  }
  
  private func bind() {
    fetchUseCase.fetchProduct(productId)
      .map { $0.toEneity() }
      .bind(to: productObservable)
      .disposed(by: disposeBag)
  }
  
  func modiftProduct(product: ProductRequestDTO) {
    editUseCase.modifyProduct(id: productId, product: product)
      .subscribe { _ in
        
      }
      .disposed(by: disposeBag)
  }
}
