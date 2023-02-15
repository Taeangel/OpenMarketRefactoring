//
//  EditStorage.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

import Foundation
import RxSwift

protocol EditStorageable: AnyObject {
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void>
  func deleteProduct(id: Int) -> Observable<Void>
}

final class EditStorage {
  private let openMarketApiManager: ApiManager
  
  init(openMarketApiManager: ApiManager) {
    self.openMarketApiManager = openMarketApiManager
  }
  
}

extension EditStorage: EditStorageable {
  
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void> {
    return openMarketApiManager.requestObservable(.modifyProduct(id: id, product: product))
      .map { _ in }
  }
  
  func deleteProduct(id: Int) -> Observable<Void> {
    return openMarketApiManager.requestObservable(.productDeletionURISearch(id: id))
      .compactMap {  String(data: $0, encoding: .utf8) }
      .flatMap { self.openMarketApiManager.requestObservable(.deleteProduct(endpoint: $0)) }
      .map { _ in }
  }
}
