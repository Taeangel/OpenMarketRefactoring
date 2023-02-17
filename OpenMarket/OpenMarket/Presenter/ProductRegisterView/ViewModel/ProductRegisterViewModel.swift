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
  func appendImage(image: UIImage)
}

final class ProductRegisterViewModel: ProductRegisterViewModelable {
 var imageCountObserable: BehaviorRelay<Int>
  private let registerUseCase: RegisterUseCaseable
  var imagesObserable: BehaviorRelay<[UIImage]>
  
  init(registerUseCase: RegisterUseCaseable) {
    self.registerUseCase = registerUseCase
    self.imagesObserable = .init(value: [])
    self.imageCountObserable = .init(value: 0)
  }
  
  func appendImage(image: UIImage) {
    imagesObserable.accept(imagesObserable.value + [image])
    imageCountObserable.accept(imageCountObserable.value + 1)
  }
}
