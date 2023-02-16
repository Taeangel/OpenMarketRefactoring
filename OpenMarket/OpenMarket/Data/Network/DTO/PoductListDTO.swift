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
  var product: [BasicProductEntity]?
  
  enum CodingKeys: String, CodingKey {
    case pageNo, itemsPerPage, totalCount, offset, limit, lastPage, hasNext, hasPrev
    case product = "pages"
  }
}
