//
//  OpenMarketApiManager.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol OpenMarketProtocol {
  func requestObservable(_ request: OpenMarketRequestManager) -> Observable<Data>
}

protocol Requestable {
  func request(_ request: OpenMarketRequestManager) -> Observable<Data>
}

struct ApiManager: OpenMarketProtocol {
  
  let session: Requestable
  
  init(session: Requestable) {
    self.session = session
  }
  
  func requestObservable(_ request: OpenMarketRequestManager) -> Observable<Data> {
    return session.request(request)
  }
}
extension URLSession: Requestable {
  func request(_ request: OpenMarketRequestManager) -> Observable<Data> {
    return URLSession.shared.rx.response(request: request.urlRequest)
      .map(filterURLData)
  }
  
  private func filterURLData(urlResponse: URLResponse, data: Data) throws -> Data {
    
    guard let httpResponse = urlResponse as? HTTPURLResponse else {
      throw NetworkError.unknown
    }
    
    switch httpResponse.statusCode {
    case 401:
      throw NetworkError.unauthorized
    case 204:
      throw NetworkError.noContent
    default:
      break
    }
    
    if !(200...299).contains(httpResponse.statusCode) {
      throw NetworkError.badStatus(code: httpResponse.statusCode)
    }
    
    return data
  }
}
