//
//  OpenMarketUseCase.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation
import RxSwift

protocol FetchUseCaseable {
  func fetchProductList() -> Observable<PoductListDTO>
  func fetchProduct(_ id: Int) -> Observable<ProductDTO>
}

final class FetchUseCase {
  private let openMarketRepository: FetchRepositorible
  
  init(openMarketRepository: FetchRepositorible) {
    self.openMarketRepository = openMarketRepository
  }
}

extension FetchUseCase: FetchUseCaseable {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    openMarketRepository.fetchProductList()
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    openMarketRepository.fetchProduct(id)
  }
}
