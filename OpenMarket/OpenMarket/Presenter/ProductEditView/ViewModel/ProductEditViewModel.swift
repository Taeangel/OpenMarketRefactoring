//
//  ProductEditViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation

protocol ProductEditViewModelable {
  
}

final class ProductEditViewModel: ProductEditViewModelable {
  private let fetchUseCase: FetchUseCaseable
  private let editUseCase: EditUseCaseable
  
  init(
    fetchUseCase: FetchUseCaseable,
    editUseCase: EditUseCaseable
  ) {
    self.fetchUseCase = fetchUseCase
    self.editUseCase = editUseCase
  }
}

