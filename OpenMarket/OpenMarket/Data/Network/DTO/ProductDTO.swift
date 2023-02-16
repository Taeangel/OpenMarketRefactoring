//
//  ProductModel.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation

struct ProductDTO: Codable {
  let id, vendorID: Int?
  let name, productDescription: String?
  let thumbnail: String?
  let currency: String?
  let price, bargainPrice, discountedPrice, stock: Int?
  let createdAt, issuedAt: String?
  let images: [ProductImageDTO]
  let vendors: VendorsDTO?
  
  enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case name
    case productDescription = "description"
    case thumbnail, currency, price
    case bargainPrice = "bargain_price"
    case discountedPrice = "discounted_price"
    case stock
    case createdAt = "created_at"
    case issuedAt = "issued_at"
    case images, vendors
  }
  
  func toEneity() -> DetailProductEneity {
    return DetailProductEneity(
      id: id,
      vendorID: vendorID,
      name: name,
      productDescription: productDescription,
      currency: currency,
      price: price,
      discountedPrice: discountedPrice,
      stock: stock,
      images: images.map{ $0.toEntity() },
      vendors: vendors.map { $0.toEntity() }
    )
  }
}

// MARK: - Image
struct ProductImageDTO: Codable, Identifiable {
  let id: Int?
  let url, thumbnailURL: String?
  let issuedAt: String?
  
  enum CodingKeys: String, CodingKey {
    case id, url
    case thumbnailURL = "thumbnail_url"
    case issuedAt = "issued_at"
  }
  
  func toEntity() -> ProductImageEntity {
    ProductImageEntity(id: id, url: url)
  }
}

// MARK: - Vendors
struct VendorsDTO: Codable {
  let id: Int?
  let name: String?
  
  func toEntity() -> VendorsEntity {
    VendorsEntity(id: id, name: name)
  }
}
