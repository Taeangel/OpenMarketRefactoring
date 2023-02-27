//
//  RegisterRepositoriable.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import RxSwift
import Foundation

protocol RegisterRepositoriable {
  func postProduct(params: ProductRequestDTO, images: [Data]) -> Observable<Void>
}
