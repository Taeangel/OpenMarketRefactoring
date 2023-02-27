//
//  OpenMarketRequestManager.swift
//  OpenMarket
//
//  Created by song on 2023/02/13.
//

import Foundation

enum OpenMarketRequestManager {
  
  case getProductList(page_no: Int = 1, items_per_page: Int = 20)
  case getProduct(_ id: Int)
  case postProduct(params: ProductRequestDTO, images: [Data])
  case getMyProductList(page_no: Int = 1, items_per_page: Int = 1, search_value: String = "red")
  case getSearchProductList(page_no: Int = 1, items_per_page: Int = 10, search_value: String = "")
  case productDeletionURISearch(id: Int)
  case deleteProduct(endpoint: String)
  case modifyProduct(id: Int, product: ProductRequestDTO)
  
  private var BaseURLString: String {
    return "https://openmarket.yagom-academy.kr"
  }
  
  private var endPoint: String {
    switch self {
    case .getProductList:
      return "/api/products?"
    case let .getProduct(id) :
      return "/api/products/\(id)"
    case .postProduct:
      return "/api/products"
    case .getMyProductList:
      return "/api/products?"
    case let .productDeletionURISearch(id):
      return "/api/products/\(id)/archived"
    case let .deleteProduct(endpoint):
      return "\(endpoint)"
    case let .modifyProduct(id, _):
      return "/api/products/\(id)/"
    case .getSearchProductList:
      return "/api/products?"
    }
  }
  
  private var method: HTTPMethod {
    switch self {
    case .getProductList:
      return .get
    case .getProduct:
      return .get
    case .postProduct:
      return .post
    case .getMyProductList:
      return .get
    case .productDeletionURISearch:
      return .post
    case .deleteProduct:
      return .delete
    case .modifyProduct:
      return .patch
    case .getSearchProductList:
      return .get
    }
  }
  
  private var parameters: [String: Any]? {
    switch self {
    case let .getProductList(page_no, items_per_page):
      var params: [String: Any] = [:]
      params["page_no"] = page_no
      params["items_per_page"] = items_per_page
      return params
    case .getProduct:
      return nil
    case .postProduct:
      return nil
    case let .getMyProductList(page_no, items_per_page, search_value):
      var params: [String: Any] = [:]
      params["page_no"] = page_no
      params["items_per_page"] = items_per_page
      params["search_value"] = search_value
      return params
    case .productDeletionURISearch:
      return nil
    case .deleteProduct:
      return nil
    case .modifyProduct:
      return nil
    case let .getSearchProductList(page_no, items_per_page, search_value):
      var params: [String: Any] = [:]
      params["page_no"] = page_no
      params["items_per_page"] = items_per_page
      params["search_value"] = search_value
      return params
    }
  }
  
  private var headerFields: [String: String]? {
    switch self {
    case .getProductList:
      return nil
    case .getProduct:
      return nil
    case let .postProduct(params, _):
      return ["identifier": "81da9d11-4b9d-11ed-a200-81a344d1e7cb", "Content-Type": "multipart/form-data; boundary=\(params.boundary)"]
    case .getMyProductList:
      return nil
    case .productDeletionURISearch:
      return ["identifier": "81da9d11-4b9d-11ed-a200-81a344d1e7cb", "Content-Type": "application/json"]
    case .deleteProduct:
      return ["identifier": "81da9d11-4b9d-11ed-a200-81a344d1e7cb"]
    case .modifyProduct:
      return ["identifier": "81da9d11-4b9d-11ed-a200-81a344d1e7cb", "Content-Type" : "application/json"]
    case .getSearchProductList:
      return nil
    }
  }
  
  private var bodyData: Data? {
    switch self {
    case .getProductList:
      return nil
    case .getProduct:
      return nil
    case let .postProduct(params, images):
      let paramsData = try? JSONEncoder().encode(params)
      var multipartFormParts: [Datapart] = []
      images.forEach { multipartFormParts.append(Datapart(name: "images", data: $0, filename: "", contentType: "image/jpeg"))}
      multipartFormParts.append(Datapart(name: "params", data: paramsData ?? Data(), filename: "", contentType: "application/json"))
      return MultipartForm(parts: multipartFormParts, boundary: params.boundary).bodyData
    case .getMyProductList:
      return nil
    case .productDeletionURISearch:
      return try? JSONEncoder().encode(Secret())
    case .deleteProduct:
      return nil
    case let .modifyProduct(_, product):
      return try? JSONEncoder().encode(product)
    case .getSearchProductList:
      return nil
    }
  }
  
  var urlRequest: URLRequest {
    var components = URLComponents(string: BaseURLString + endPoint)
    
    if let parameters {
      components?.queryItems = parameters.map { key, value in
        URLQueryItem(name: key, value: "\(value)")
      }
    }
    
    var request = URLRequest(url: (components?.url) ?? URL(fileURLWithPath: ""))
    request.httpMethod = method.rawValue
    
    if let headerFields {
      headerFields.forEach {
        request.addValue($0.value, forHTTPHeaderField: $0.key)
      }
    }
    
    if let bodyData  {
      request.httpBody = bodyData
    }
  
    return request
  }
}

