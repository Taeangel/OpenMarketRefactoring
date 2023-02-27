//
//  ProductImageEntity.swift
//  OpenMarket
//
//  Created by song on 2023/02/28.
//

import Foundation

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
