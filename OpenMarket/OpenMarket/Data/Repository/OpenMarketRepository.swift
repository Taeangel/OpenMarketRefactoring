//
//  OpenMarketRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift

final class OpenMarketRepository {
  private let openMarketStorageable: OpenMarketStorageable
  
  init(openMarketStorageable: OpenMarketStorageable) {
    self.openMarketStorageable = openMarketStorageable
  }
}

extension OpenMarketRepository: OpenMarketRepositorible {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    openMarketStorageable.fetchProductList()
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    openMarketStorageable.fetchProduct(id)
  }
}
