//
//  OpenMarketRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift

final class FetchRepository {
  private let openMarketStorageable: FetchStorageable
  
  init(openMarketStorageable: FetchStorageable) {
    self.openMarketStorageable = openMarketStorageable
  }
}

extension FetchRepository: FetchRepositorible {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    openMarketStorageable.fetchProductList()
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    openMarketStorageable.fetchProduct(id)
  }
}
