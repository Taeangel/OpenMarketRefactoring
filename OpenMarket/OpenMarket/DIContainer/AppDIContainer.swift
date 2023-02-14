//
//  DIContainer.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

protocol AppDIContainerable {
  
}

final class AppDIContainer: AppDIContainerable {
  private let apiManager = ApiManager(session: URLSession.shared)
  private let openMarketStorage: OpenMarketStorage

  init() {
    self.openMarketStorage = .init(openMarketApiManager: apiManager)
  }
  
  func makeOpenMarketDIContainer() -> OpenMarketDIContainer {
    return OpenMarketDIContainer(
      dependencies: OpenMarketDIContainer.Dependencies(
        openMarketStorage: openMarketStorage
      )
    )
  }
}
