//
//  DIContainer.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

final class AppDIContainer {
  private let apiManager = ApiManager(session: URLSession.shared)
  private let openMarketStorage: FetchStorage

  init() {
    self.openMarketStorage = .init(openMarketApiManager: apiManager)
  }
  
  func makeOpenMarketDIContainer() -> OpenMarketDIContainer {
    return OpenMarketDIContainer(
      dependencies: OpenMarketDIContainer.Dependencies(
        fetchStorage: openMarketStorage
      )
    )
  }
}
