//
//  NetworkError.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation

enum NetworkError: Error {
  case network(error: Error)
  case decoding(error: Error)
  case unknown
  case unauthorized
  case noContent
  case badStatus(code: Int)
}
