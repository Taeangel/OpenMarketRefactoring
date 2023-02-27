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
  var delegate: ProductModifyViewModelDelegate? { get set }
  func action(action: ProductModifyViewModel.ViewAction)
}

protocol ProductModifyViewModelDelegate: AnyObject {
  func coordinatorDismiss()
}

class ProductModifyViewModel: ProductModifyViewModelable {
  weak var delegate: ProductModifyViewModelDelegate?
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
  
  func action(action: ViewAction) {
    switch action {
    case .buttonTap(let tag):
      guard let buttonDetail = ButtonDetail(rawValue: tag) else { return }
      switch buttonDetail {
      case .modifyProduct:
        editUseCase.modifyProduct(id: productId, product: productObserableDTO.value)
          .subscribe { _ in }
          .disposed(by: disposeBag)
        delegate?.coordinatorDismiss()
      }
    }
  }
  
  func modiftProduct() {
    editUseCase.modifyProduct(id: productId, product: productObserableDTO.value)
      .subscribe { _ in }
      .disposed(by: disposeBag)
  }
}

// MARK: - Action

extension ProductModifyViewModel {
  enum ViewAction {
    case buttonTap(Int)
    
  }
  
  enum ButtonDetail: Int {
    case modifyProduct = 100
  }
}

// MARK: - Binding

extension ProductModifyViewModel {
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
}
