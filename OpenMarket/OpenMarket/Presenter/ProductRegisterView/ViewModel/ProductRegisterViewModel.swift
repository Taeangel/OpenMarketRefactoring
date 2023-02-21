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
  var productObserable: BehaviorRelay<ProductRequestDTO> { get set }
  var buttonAble: BehaviorRelay<Bool> { get set }
  func appendImage(image: UIImage)
  func didTappostButton(param: ProductRequestDTO)
}

final class ProductRegisterViewModel: ProductRegisterViewModelable {
  var productObserable: BehaviorRelay<ProductRequestDTO>
  private var disposeBag: DisposeBag
  var imageCountObserable: BehaviorRelay<Int>
  private let registerUseCase: RegisterUseCaseable
  var imagesObserable: BehaviorRelay<[UIImage]>
  var buttonAble: BehaviorRelay<Bool>
  var imagesData: [Data]
  
  init(registerUseCase: RegisterUseCaseable) {
    self.buttonAble = .init(value: false)
    self.registerUseCase = registerUseCase
    self.disposeBag = .init()
    self.imagesObserable = .init(value: [])
    self.imageCountObserable = .init(value: 0)
    self.imagesData = .init()
    self.productObserable = .init(value: ProductRequestDTO())
  }

  func appendImage(image: UIImage) {
    imagesObserable.accept(imagesObserable.value + [image])
    imageCountObserable.accept(imageCountObserable.value + 1)
  }
  
  private func convertImageToData() {
    imagesObserable
      .compactMap { $0.map{ $0.jpegData(compressionQuality: 0.1) ?? Data() } }
      .subscribe { event in
        switch event {
        case let .next(datas):
          self.imagesData = datas
        default:
          break
        }
      }
      .disposed(by: disposeBag)
  }
  
  func didTappostButton(param: ProductRequestDTO) {
    convertImageToData()
    registerUseCase.fetchProductList(params: param, images: imagesData)
      .observe(on: MainScheduler.instance)
      .withUnretained(self)
      .subscribe(onDisposed:  {
      })
      .disposed(by: disposeBag)
    cleanImage()
    buttonAble.accept(false)
  }
  
  private func cleanImage() {
    imagesObserable.accept([])
    imageCountObserable.accept(0)
  }
}



