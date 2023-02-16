//
//  DetailProductEneity.swift
//  OpenMarket
//
//  Created by song on 2023/02/16.
//

import Foundation

struct DetailProductEneity: Codable {
  let id, vendorID: Int?
  let name, productDescription: String?
  let currency: String?
  let price, discountedPrice, stock: Int?
  let images: [ProductImageEntity]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case name
    case productDescription = "description"
    case currency, price
    case discountedPrice = "discounted_price"
    case stock
    case images
  }
  
  var arrayImages: [ProductImageEntity] {
    guard let images = images else {
      return []
    }
    return images
  }
}

// MARK: - Image
struct ProductImageEntity: Codable, Identifiable {
  let id: Int?
  let url: String?
  
  var imageURL: URL {
    guard let url = url, let url = URL(string: url) else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
  
  enum CodingKeys: String, CodingKey {
    case id, url
  }
}

