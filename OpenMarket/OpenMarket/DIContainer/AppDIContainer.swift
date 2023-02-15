//
//  DIContainer.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import Foundation

final class AppDIContainer {
  private let apiManager: ApiManager
  private let fetchStorage: FetchStorage
  private let registerStorage: RegisterStorage
  private let editStorage: EditStorage

  init() {
    self.apiManager = .init(session: URLSession.shared)
    self.fetchStorage = .init(openMarketApiManager: apiManager)
    self.registerStorage = .init(openMarketApiManager: apiManager)
    self.editStorage = .init(openMarketApiManager: apiManager)
  }
  
  func makeOpenMarketDIContainer() -> OpenMarketDIContainer {
    return OpenMarketDIContainer(
      dependencies: OpenMarketDIContainer.Dependencies(
        fetchStorage: fetchStorage,
        registerStorage: registerStorage,
        editStorage: editStorage
      )
    )
  }
}
