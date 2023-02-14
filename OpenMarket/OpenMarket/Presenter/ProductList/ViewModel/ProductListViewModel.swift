//
//  ProductListViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

protocol ProductListViewModelable {
  
}

final class ProductListViewModel: ProductListViewModelable {
  private let fetchUseCase: FetchUseCaseable
  
  init(fetchUseCase: FetchUseCaseable) {
    self.fetchUseCase = fetchUseCase
  }
}
