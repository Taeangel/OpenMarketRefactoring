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
  
  init(id: Int?, vendorID: Int?, name: String?, productDescription: String?, currency: String?, price: Int?, discountedPrice: Int?, stock: Int?, images: [ProductImageEntity]?) {
    self.id = id
    self.vendorID = vendorID
    self.name = name
    self.productDescription = productDescription
    self.currency = currency
    self.price = price
    self.discountedPrice = discountedPrice
    self.stock = stock
    self.images = images
  }
  
  init() {
    self.id = nil
    self.vendorID = nil
    self.name = nil
    self.productDescription = nil
    self.currency = nil
    self.price = nil
    self.discountedPrice = nil
    self.stock = nil
    self.images = nil
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

