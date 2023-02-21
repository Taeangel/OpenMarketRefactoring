//
//  Product.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation

struct ProductRequestDTO: Encodable {
  let name: String
  let description: String
  let price: Int
  let currency: String
  let discountedPrice: Int
  let stock: Int
  let secret: String = "bjv33pu73cbajp1"
  let boundary: String = UUID().uuidString
  
  init(name: String, description: String, price: Int, currency: String, discountedPrice: Int, stock: Int) {
    self.name = name
    self.description = description
    self.price = price
    self.currency = currency
    self.discountedPrice = discountedPrice
    self.stock = stock
  }
  
  init() {
    self.name = ""
    self.description = ""
    self.price = 0
    self.currency = "KRW"
    self.discountedPrice = 0
    self.stock = 0
  }
  
  enum CodingKeys: String, CodingKey {
    case name
    case description
    case price
    case currency
    case discountedPrice = "discounted_price"
    case stock
    case secret
  }
}

