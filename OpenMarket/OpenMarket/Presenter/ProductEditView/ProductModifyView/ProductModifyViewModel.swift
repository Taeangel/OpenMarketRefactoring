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
  var nameObserable: BehaviorRelay<String> { get set }
  var priceObserable: BehaviorRelay<Int> { get set }
  var discountPriceObserable: BehaviorRelay<Int> { get set }
  var stockPriceObserable: BehaviorRelay<Int> { get set }
  var descriptionObserable: BehaviorRelay<String> { get set }
  var productObservable: BehaviorRelay<DetailProductEneity> { get set }
  func modiftProduct()
}

class ProductModifyViewModel: ProductModifyViewModelable {
  
  var nameObserable: BehaviorRelay<String>
  var priceObserable: BehaviorRelay<Int>
  var discountPriceObserable: BehaviorRelay<Int>
  var stockPriceObserable: BehaviorRelay<Int>
  var descriptionObserable: BehaviorRelay<String>
  var productObservable: BehaviorRelay<DetailProductEneity>
  
  private var productObserableDTO: BehaviorRelay<ProductRequestDTO>
  private var productId: Int
  private var disposeBag: DisposeBag
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
    self.productObserableDTO = .init(value: ProductRequestDTO())
        
    self.nameObserable = .init(value: "")
    self.priceObserable = .init(value: 0)
    self.discountPriceObserable = .init(value: 0)
    self.stockPriceObserable = .init(value: 0)
    self.descriptionObserable = .init(value: "")
    
    bind()
    convertDataBinding()
  }
  
  private func convertDataBinding() {
    Observable.combineLatest(
      nameObserable,
      priceObserable,
      discountPriceObserable,
      stockPriceObserable,
      descriptionObserable
    ).map { name, price, discount, stockPrice, description in
      ProductRequestDTO(
        name: name,
        description: description,
        price: price,
        currency: "KRW",
        discountedPrice: discount,
        stock: stockPrice
      )
    }
    .bind(to: productObserableDTO)
    .disposed(by: disposeBag)
  }
  
  private func bind() {
    fetchUseCase.fetchProduct(productId)
      .map { $0.toEneity() }
      .bind(to: productObservable)
      .disposed(by: disposeBag)
  }
  
  func modiftProduct() {
    editUseCase.modifyProduct(id: productId, product: productObserableDTO.value)
      .subscribe { _ in }
      .disposed(by: disposeBag)
  }
}
