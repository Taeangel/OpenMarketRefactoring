//
//  PoductListModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation

struct PoductListDTO: Codable {
  let pageNo, itemsPerPage, totalCount, offset: Int?
  let limit, lastPage: Int?
  let hasNext, hasPrev: Bool?
  var product: [BasicProductDTO]?
  
  enum CodingKeys: String, CodingKey {
    case pageNo, itemsPerPage, totalCount, offset, limit, lastPage, hasNext, hasPrev
    case product = "pages"
  }
}

struct BasicProductDTO: Codable, Identifiable, Equatable {
  let id, vendorID: Int?
  let vendorName, name, description: String?
  let thumbnail: String?
  let currency: String?
  let price, bargainPrice, discountedPrice, stock: Int?
  
  enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case vendorName, name
    case description = "description"
    case thumbnail, currency, price
    case bargainPrice = "bargain_price"
    case discountedPrice = "discounted_price"
    case stock
  }
  
  func toEneity() -> BasicProductEntity {
    return BasicProductEntity(
      id: id,
      vendorID: vendorID,
      vendorName: vendorName,
      name: name,
      description: description,
      thumbnail: thumbnail,
      currency: currency,
      price: price,
      bargainPrice: bargainPrice,
      discountedPrice: discountedPrice,
      stock: stock)
  }
}
