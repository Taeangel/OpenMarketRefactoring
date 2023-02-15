//
//  ProductEntity.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

struct ProductEntity: Codable, Identifiable, Equatable {
  let id, vendorID: Int?
  let vendorName, name, pageDescription: String?
  let thumbnail: String?
  let currency: String?
  let price, bargainPrice, discountedPrice, stock: Int?
  let createdAt, issuedAt: String?
  
  var thumbnailURL: URL {
    guard let tumbnailString = thumbnail, let url = URL(string: tumbnailString) else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
  
  var moneySign: String {
    if currency == "USD" {
      return "$"
    } else {
      return "₩"
    }
  }
  
  var priceString: String {
    guard let price = price else {
      return ""
    }
    return "\(moneySign)\(price)"
  }
  
  var discountedPriceString: String {
    guard let discountedPrice = discountedPrice else {
      return ""
    }
    return "\(moneySign)\(discountedPrice)"
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case vendorName, name
    case pageDescription = "description"
    case thumbnail, currency, price
    case bargainPrice = "bargain_price"
    case discountedPrice = "discounted_price"
    case stock
    case createdAt = "created_at"
    case issuedAt = "issued_at"
  }
}
