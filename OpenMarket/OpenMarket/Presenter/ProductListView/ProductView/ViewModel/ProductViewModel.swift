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
    case .buttonTap(let tag):
      guard let buttonDetail = ButtonDetail(rawValue: tag) else { return }
      
      switch buttonDetail {
      case .back:
        self.delegate?.dismiss()
      }
    }
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

extension ProductViewModel {
  enum ViewAction {
    case buttonTap(Int)
  }
  
  enum ButtonDetail: Int {
    case back = 100
  }
}
