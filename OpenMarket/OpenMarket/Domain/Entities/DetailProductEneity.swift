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
  let vendors: VendorsEntity?
  
  enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case name
    case productDescription = "description"
    case currency, price
    case discountedPrice = "discounted_price"
    case stock
    case images
    case vendors
  }
  
  init(id: Int?, vendorID: Int?, name: String?, productDescription: String?, currency: String?, price: Int?, discountedPrice: Int?, stock: Int?, images: [ProductImageEntity]?, vendors: VendorsEntity?) {
    self.id = id
    self.vendorID = vendorID
    self.name = name
    self.productDescription = productDescription
    self.currency = currency
    self.price = price
    self.discountedPrice = discountedPrice
    self.stock = stock
    self.images = images
    self.vendors = vendors
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
    self.vendors = nil
  }
}

extension DetailProductEneity {
  
  var arrayImages: [ProductImageEntity] {
    guard let images = images else {
      return []
    }
    return images
  }

  var nameString: String {
    guard let name = name else { return ""}
    return name
  }
  
  var descriptionString: String {
    guard let description = productDescription else { return ""}
    return description
  }
  
  private var moneySign: String {
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
  
  var stockString: String {
    guard let stock = stock else {
      return ""
    }
    return "\(stock)"
  }
  
  var priceInt: Int {
    guard let price = price else {
       return 0
    }
    return price
  }
  
  var currencyString: String {
    guard let currency = currency else  {
      return ""
    }
    return currency
  }
  
  var stockInt: Int {
    guard let stock = stock else {
      return 0
    }
    return stock
  }
  
  var discountedInt: Int {
    guard let discountedPrice = discountedPrice else {
      return 0
    }
    return discountedPrice
  }
}


// MARK: - Image

// MARK: - Vendors
