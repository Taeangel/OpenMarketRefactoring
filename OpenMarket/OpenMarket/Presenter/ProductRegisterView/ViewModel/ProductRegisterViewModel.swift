//
//  ProductRegisterViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductRegisterViewModelable {
  var imagesObserable: BehaviorRelay<[UIImage]> { get set }
  var imageCountObserable: BehaviorRelay<Int> { get set }
  var isProductUpdatebutton: BehaviorRelay<Bool> { get set }
  var nameObserable: BehaviorRelay<String> { get set }
  var priceObserable: BehaviorRelay<Int> { get set }
  var discountPriceObserable: BehaviorRelay<Int> { get set }
  var stockPriceObserable: BehaviorRelay<Int> { get set }
  var descriptionObserable: BehaviorRelay<String> { get set }
  func action(action: ProductRegisterViewModel.ViewAction)
  var delegate: RegistetViewModelDelegate? { get set }
}

protocol RegistetViewModelDelegate: AnyObject {
  func coordinatorImagePicker()
}

class ProductRegisterViewModel: ProductRegisterViewModelable {
  weak var delegate: RegistetViewModelDelegate?
  var nameObserable: BehaviorRelay<String>
  var priceObserable: BehaviorRelay<Int>
  var discountPriceObserable: BehaviorRelay<Int>
  var stockPriceObserable: BehaviorRelay<Int>
  var descriptionObserable: BehaviorRelay<String>
  var productObserable: BehaviorRelay<ProductRequestDTO>
  private var disposeBag: DisposeBag
  var imageCountObserable: BehaviorRelay<Int>
  private let registerUseCase: RegisterUseCaseable
  var imagesObserable: BehaviorRelay<[UIImage]>
  var isProductUpdatebutton: BehaviorRelay<Bool>
  var imagesData: [Data]
  
  init(registerUseCase: RegisterUseCaseable) {
    self.isProductUpdatebutton = .init(value: false)
    self.registerUseCase = registerUseCase
    self.disposeBag = .init()
    self.imagesObserable = .init(value: [])
    self.imageCountObserable = .init(value: 0)
    self.imagesData = .init()
    self.productObserable = .init(value: ProductRequestDTO())
    self.nameObserable = .init(value: "")
    self.priceObserable = .init(value: 0)
    self.discountPriceObserable = .init(value: 0)
    self.stockPriceObserable = .init(value: 0)
    self.descriptionObserable = .init(value: "")
    convertToData()
    postButtonAbleObserable()
  }
  
  func action(action: ViewAction) {
    switch action {
    case .buttonTap(let tag):
      guard let buttonDetail = ButtonDetail(rawValue: tag) else { return }
      switch buttonDetail {
      case .updateProduct:
        registerUseCase.postProduct(params: productObserable.value, images: imagesData)
          .observe(on: MainScheduler.instance)
          .subscribe(onDisposed:  {
          })
          .disposed(by: disposeBag)
        resetView()
      }
    case .saveImage(let image):
      imagesObserable.accept(imagesObserable.value + [image])
      imageCountObserable.accept(imageCountObserable.value + 1)
    case .addImageButtonTap:
      self.delegate?.coordinatorImagePicker()
    }
  }
}
  
// MARK: - Action

extension ProductRegisterViewModel {
  enum ViewAction {
    case buttonTap(Int)
    case saveImage(UIImage)
    case addImageButtonTap
  }

  enum ButtonDetail: Int {
    case updateProduct = 100
  }
}

// MARK: - Binding Method

extension ProductRegisterViewModel {
  private func convertToData() {
    imagesObserable
      .compactMap { $0.compactMap { $0.jpegData(compressionQuality: 0.3) } }
      .subscribe(onNext: { [weak self] in self?.imagesData = $0 })
      .disposed(by: disposeBag)
    
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
    }.bind(to: productObserable)
      .disposed(by: disposeBag)
  }
  
  private func postButtonAbleObserable() {
    let nameTextObserable = nameObserable
      .map { $0 != "" }
    
    let priceTextObserable = priceObserable
      .compactMap { $0 }
      .compactMap { Int($0) }
    
    let discountedPriceObserable = discountPriceObserable
      .compactMap { $0 }
      .compactMap { Int($0) }
    
    let priceObserable = BehaviorRelay.combineLatest(priceTextObserable, discountedPriceObserable)
      .map { $0 > $1 }
    
    let stockTextObserable =  stockPriceObserable
      .compactMap { $0 }
      .compactMap { Int($0) }
      .map { $0 > 0}
    
    let descriptionTextObserable = descriptionObserable
      .map { $0 != "" }
    
    let imageCountObserable = imageCountObserable
      .map { $0 > 0}
    
    Observable.combineLatest(
      nameTextObserable,
      priceObserable,
      stockTextObserable,
      descriptionTextObserable,
      imageCountObserable
    ) { $0 && $1 && $2 && $3 && $4 }
      .bind(to: isProductUpdatebutton)
      .disposed(by: disposeBag)
  }
  
  private func resetView() {
    imagesObserable.accept([])
    imageCountObserable.accept(0)
    isProductUpdatebutton.accept(false)
    nameObserable.accept("")
    priceObserable.accept(0)
    discountPriceObserable.accept(0)
    stockPriceObserable.accept(0)
    descriptionObserable.accept("")
  }
}


