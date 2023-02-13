//
//  OpenMarketStorage.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift

protocol OpenMarketStorageable: AnyObject {
  func fetchProductList() -> Observable<PoductListDTO>
  func fetchProduct(_ id: Int) -> Observable<ProductDTO>
}

final class OpenMarketStorage {
  private let openMarketApiManager: ApiManager
  
  init(openMarketApiManager: ApiManager) {
    self.openMarketApiManager = openMarketApiManager
  }
}

extension OpenMarketStorage: OpenMarketStorageable {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    return openMarketApiManager.requestObservable(.getProductList())
      .compactMap {
        return try? JSONDecoder().decode(PoductListDTO.self, from: $0)
      }
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    return openMarketApiManager.requestObservable(.getProduct(id))
      .compactMap {
        return try? JSONDecoder().decode(ProductDTO.self, from: $0)
      }
  }
}
