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
  func fetchMyProductList() -> Observable<PoductListDTO>
}

final class FetchUseCase {
  private let fetchRepository: FetchRepositorible
  
  init(fetchRepository: FetchRepositorible) {
    self.fetchRepository = fetchRepository
  }
}

extension FetchUseCase: FetchUseCaseable {
  func fetchProductList() -> RxSwift.Observable<PoductListDTO> {
    fetchRepository.fetchProductList()
  }
  
  func fetchProduct(_ id: Int) -> RxSwift.Observable<ProductDTO> {
    fetchRepository.fetchProduct(id)
  }
  
  func fetchMyProductList() -> Observable<PoductListDTO> {
    fetchRepository.fetchMyProductList()
  }
  
}
