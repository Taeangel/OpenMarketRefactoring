//
//  OpenMarketRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift

protocol FetchRepositorible {
  func fetchProductList() -> Observable<PoductListDTO>
  func fetchProduct(_ id: Int) -> Observable<ProductDTO>
}
