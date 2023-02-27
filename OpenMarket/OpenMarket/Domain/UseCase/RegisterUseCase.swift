//
//  RegisterUseCase.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift

protocol RegisterUseCaseable {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> Observable<Void>
}

final class RegisterUseCase {
  private let registerRepository: RegisterRepositoriable
  
  init(registerRepository: RegisterRepositoriable) {
    self.registerRepository = registerRepository
  }
}

extension RegisterUseCase: RegisterUseCaseable {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> RxSwift.Observable<Void> {
    registerRepository.postProduct(params: params, images: images)
  }
}
