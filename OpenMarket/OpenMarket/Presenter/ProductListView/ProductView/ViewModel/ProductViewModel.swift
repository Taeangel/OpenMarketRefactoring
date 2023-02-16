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
  var productObservable: PublishRelay<DetailProductEneity> { get set }
}

class ProductViewModel: ProductViewModelable {
  private var disposeBag: DisposeBag
  var productObservable: PublishRelay<DetailProductEneity>
  let productID: Int
  private let fetchUseCase: FetchUseCaseable
  
  init(
    productID: Int,
    fetchUseCase: FetchUseCaseable
  ) {
    
    let product = DetailProductEneity(
      id: nil,
      vendorID: nil,
      name: nil,
      productDescription: nil,
      currency: nil,
      price: nil,
      discountedPrice: nil,
      stock: nil,
      images: nil
    )
    
    self.disposeBag = .init()
    self.productID = productID
    self.fetchUseCase = fetchUseCase
    self.productObservable = .init()
    
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
