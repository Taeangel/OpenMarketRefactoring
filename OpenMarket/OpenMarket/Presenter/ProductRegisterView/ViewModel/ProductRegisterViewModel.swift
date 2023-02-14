//
//  ProductRegisterViewModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

protocol ProductRegisterViewModelable {
  
}

final class ProductRegisterViewModel: ProductRegisterViewModelable {
  private let registerUseCase: RegisterUseCaseable
  
  init(registerUseCase: RegisterUseCaseable) {
    self.registerUseCase = registerUseCase
  }
}
