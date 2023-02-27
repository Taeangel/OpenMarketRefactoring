//
//  RegisterRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift

final class RegisterRepository {
  private let registerStorageable: RegisterStorageable
  
  init(registerStorageable: RegisterStorageable) {
    self.registerStorageable = registerStorageable
  }
}

extension RegisterRepository: RegisterRepositoriable {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> RxSwift.Observable<Void> {
    registerStorageable.postProduct(params: params, images: images)
  }
}

