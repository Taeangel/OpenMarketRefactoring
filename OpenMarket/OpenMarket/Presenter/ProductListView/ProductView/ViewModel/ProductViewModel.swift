//
//  ProductViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductViewModelable {
  var productObservable: BehaviorRelay<DetailProductEneity> { get set }
}

class ProductViewModel: ProductViewModelable {
  private var disposeBag: DisposeBag
  var productObservable: BehaviorRelay<DetailProductEneity>
  let productID: Int
  private let fetchUseCase: FetchUseCaseable
  
  init(
    productID: Int,
    fetchUseCase: FetchUseCaseable
  ) {
    
    self.disposeBag = .init()
    self.productID = productID
    self.fetchUseCase = fetchUseCase
    self.productObservable = .init(value: DetailProductEneity())
    
    bind()
  }
  
  var images: Observable<[ProductImageEntity]> {
    return productObservable
      .map { product in
        product.arrayImages
      }
  }
  
  private func bind() {
    fetchUseCase.fetchProduct(productID)
      .map { $0.toEneity() }
      .bind(to: productObservable)
      .disposed(by: disposeBag)
  }
}
