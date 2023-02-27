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
  func action(action: ProductViewModel.ViewAction)
  var productObservable: BehaviorRelay<DetailProductEneity> { get set }
  var delegate: ProductViewModelDelegate? { get set }
}

protocol ProductViewModelDelegate: AnyObject {
  func dismiss()
}

class ProductViewModel: ProductViewModelable {
  weak var delegate: ProductViewModelDelegate?
  
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
  
  func action(action: ViewAction) {
    switch action {
    case .dismissTap:
      delegate?.dismiss()
    }
  }
}


// MARK: - ViewAction

extension ProductViewModel {
  enum ViewAction {
    case dismissTap
  }
}


// MARK: - Binding

extension ProductViewModel {
  private func bind() {
    fetchUseCase.fetchProduct(productID)
      .map { $0.toEneity() }
      .bind(to: productObservable)
      .disposed(by: disposeBag)
  }
}


