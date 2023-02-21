//
//  EditRepositoriable.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation
import RxSwift

protocol EditRepositoriable {
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void>
  func deleteProduct(id: Int) -> Observable<Void>
}
