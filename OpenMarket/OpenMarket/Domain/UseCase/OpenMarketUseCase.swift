//
//  OpenMarketUseCase.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift

protocol OpenMarketUseCaseable {
  func fetchProductList() -> Observable<PoductListDTO>
  func fetchProduct(_ id: Int) -> Observable<ProductDTO>
}

final class OpenMarketUseCase {
  private let openMarketRepository: OpenMarketRepositorible
  
  init(openMarketRepository: OpenMarketRepositorible) {
    self.openMarketRepository = openMarketRepository
  }
}

extension OpenMarketUseCase: OpenMarketUseCaseable {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    openMarketRepository.fetchProductList()
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    openMarketRepository.fetchProduct(id)
  }
}
