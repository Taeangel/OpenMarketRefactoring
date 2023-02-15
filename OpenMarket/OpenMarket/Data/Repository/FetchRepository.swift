//
//  OpenMarketRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift

final class FetchRepository {
  private let fetchStorageable: FetchStorageable
  
  init(fetchStorageable: FetchStorageable) {
    self.fetchStorageable = fetchStorageable
  }
}

extension FetchRepository: FetchRepositorible {
  func fetchProductList(pageNum: Int) -> RxSwift.Observable<PoductListDTO> {
    return fetchStorageable.fetchProductList(pageNum: pageNum)
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    return fetchStorageable.fetchProduct(id)
  }
  
  func fetchMyProductList() -> Observable<PoductListDTO> {
    return fetchStorageable.fetchMyProductList()
  }
}
