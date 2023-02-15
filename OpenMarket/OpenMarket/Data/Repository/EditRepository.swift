//
//  EditRepository.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation

import Foundation
import RxSwift

final class EditRepository {
  private let editStorageable: EditStorageable
  
  init(editStorageable: EditStorageable) {
    self.editStorageable = editStorageable
  }
}

extension EditRepository: EditRepositoriable {
  func deleteProduct(id: Int) -> Observable<Void> {
    return editStorageable.deleteProduct(id: id)
  }
  
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void> {
    return editStorageable.modifyProduct(id: id, product: product)
  }
  
}
