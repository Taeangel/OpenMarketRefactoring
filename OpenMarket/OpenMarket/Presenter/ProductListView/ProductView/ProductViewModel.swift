//
//  ProductViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import Foundation

protocol ProductViewModelable {
  
}

class ProductViewModel: ProductViewModelable {
  let product: ProductEntity
  private let fetchUseCase: FetchUseCaseable
  init(
    product: ProductEntity,
    fetchUseCase: FetchUseCaseable
  ) {
    self.product = product
    self.fetchUseCase = fetchUseCase
  }
}
