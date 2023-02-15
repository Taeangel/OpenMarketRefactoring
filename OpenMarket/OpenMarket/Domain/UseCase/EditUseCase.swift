//
//  EditUseCase.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import RxSwift

protocol EditUseCaseable {
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void>
  func deleteProduct(id: Int) -> Observable<Void>
}

final class EditUseCase {
  private let editRepository: EditRepositoriable
  
  init(editRepository: EditRepositoriable) {
    self.editRepository = editRepository
  }
}

extension EditUseCase: EditUseCaseable {
  func modifyProduct(id: Int, product: ProductRequestDTO) -> RxSwift.Observable<Void> {
    editRepository.modifyProduct(id: id, product: product)
  }
  
  func deleteProduct(id: Int) -> RxSwift.Observable<Void> {
    editRepository.deleteProduct(id: id)
  }
}
