//
//  ModifyViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import Foundation

protocol ProductModifyViewModelable {
  var productId: Int { get }
  
}

class ProductModifyViewModel: ProductModifyViewModelable {
  var productId: Int
  
  init(productId: Int) {
    self.productId = productId
  }
}
