//
//  RegisterStorage.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift

protocol RegisterStorageable: AnyObject {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> Observable<Void>
}

final class RegisterStorage {
  private let openMarketApiManager: ApiManager
  
  init(openMarketApiManager: ApiManager) {
    self.openMarketApiManager = openMarketApiManager
  }
}

extension RegisterStorage: RegisterStorageable {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> RxSwift.Observable<Void> {
    return openMarketApiManager
      .requestObservable(OpenMarketRequestManager.postProduct(params: params, images: images))
      .map { _ in }
  }
}
