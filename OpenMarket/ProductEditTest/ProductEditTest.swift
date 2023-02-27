//
//  ProductEditTest.swift
//  ProductEditTest
//
//  Created by song on 2023/02/28.
//

import XCTest
import RxSwift
@testable import OpenMarket

final class ProductEditTest: XCTestCase {
  
  var viewModel: ProductEditViewModelStub!
  var delegate: ProductEditViewModelDelegateStub!
  var fetchUsecase: FetchUsecaseStub!
  var editUsecase: EditUsecaseStub!
  
  override func setUp() {
    super.setUp()
    reset()
    
  }
  
  func reset() {
    fetchUsecase = FetchUsecaseStub()
    editUsecase = EditUsecaseStub()
    delegate = ProductEditViewModelDelegateStub()
    viewModel = ProductEditViewModelStub(fetchUseCase: fetchUsecase, editUseCase: editUsecase)
  }
  
  func test_삭제버튼_눌림() {

    //given
    let isValidID = 11
    editUsecase.validID = isValidID
    //when
    viewModel.action(action: .deleteProductButtonTap(isValidID))
    //then
    XCTAssertEqual(viewModel.buttonActionExcutions.count, 1)
    XCTAssertEqual(editUsecase.deleteProductExcutions.count, 1)
  }
  
  func test_updateList_작동() {
    //given
    let ProductList = PoductListDTO(
      pageNo: 1,
      itemsPerPage: 10,
      totalCount: 5,
      offset: 5,
      limit: 5,
      lastPage: 5,
      hasNext: true,
      hasPrev: true
    )
    fetchUsecase.poductListDTO = ProductList
    //when
    viewModel.action(action: .updateList)
    //then
    XCTAssertEqual(viewModel.buttonActionExcutions.count, 1)
    XCTAssertEqual(fetchUsecase.fetchMyProductListExcutions.count, 1)
  }
  
  func test_변경버튼_눌림() {
    //given
    let targetID = 9
    let productRequestDTO = ProductRequestDTO(
      name: "목",
      description: "입니다",
      price: 0,
      currency: "USD",
      discountedPrice: 0,
      stock: 0
    )
    editUsecase.productRequestDTO = productRequestDTO
    
    //when
    viewModel.action(action: .modifyProductButtonTap(targetID))
    //then
    XCTAssertEqual(viewModel.buttonActionExcutions.count, 1)
  }
}

class ProductEditViewModelStub: ProductEditViewModel {
  var buttonActionExcutions: [(ProductEditViewModel.ViewAction, Void)] = []
  override func action(action: ProductEditViewModel.ViewAction) {
    buttonActionExcutions.append((action, ()))
    super.action(action: action)
  }
}

class ProductEditViewModelDelegateStub: ProductEditViewModelDelegate {
  var coordinatorModifyViewExcutions: [(Int, Void)] = []
  func coordinatorShowModifyView(_ productID: Int) {
    coordinatorModifyViewExcutions.append((productID, ()))
  }
}

class EditUsecaseStub: EditUseCaseable {
  
  enum apiError: Error {
    case notWork
  }
  
  var validID: Int?
  var productRequestDTO: ProductRequestDTO?
  var error = apiError.notWork
  
  var modifyProductExcutions: [((Int, ProductRequestDTO), Observable<Void>)] = []
  func modifyProduct(id: Int, product: ProductRequestDTO) -> Observable<Void> {
    if productRequestDTO == nil {
      return Observable<Void>.error(error)
    } else {
      modifyProductExcutions.append(((id, product), (Observable<Void>.just(()))))
      return Observable<Void>.never()
    }
  }
  
  var deleteProductExcutions: [(Int, Observable<Void>)] = []
  func deleteProduct(id: Int) -> Observable<Void> {
    // validID가 10 이상이면 알맞은 ID라고 가정
    if validID! > 10 {
      deleteProductExcutions.append((id, (Observable<Void>.just(()))))
      return Observable<Void>.never()
    } else {
      return Observable<Void>.error(error)
    }
  }
}

class FetchUsecaseStub: FetchUseCaseable {
  
  var poductListDTO: PoductListDTO?
  var productDTO: ProductDTO?
  
  var fetchProductListExcutions: [(Int, Observable<OpenMarket.PoductListDTO>)] = []
  func fetchProductList(pageNum: Int) -> Observable<OpenMarket.PoductListDTO> {
    
    if let poductListDTO {
      fetchProductListExcutions.append((pageNum, Observable<PoductListDTO>.just(poductListDTO)))
      return Observable<PoductListDTO>.just(poductListDTO)
    } else {
      return Observable<PoductListDTO>.never()
    }
  }
  
  var fetchProductExcutions: [(Int, Observable<OpenMarket.ProductDTO>)] = []
  func fetchProduct(_ id: Int) -> Observable<OpenMarket.ProductDTO> {
    if let productDTO {
      fetchProductExcutions.append((id, Observable<OpenMarket.ProductDTO>.just(productDTO)))
      return Observable<ProductDTO>.just(productDTO)
    } else {
      return Observable<ProductDTO>.never()
    }
  }
  
  var fetchMyProductListExcutions: [((), Observable<OpenMarket.PoductListDTO>)] = []
  func fetchMyProductList() -> Observable<OpenMarket.PoductListDTO> {
    if let poductListDTO {
      fetchMyProductListExcutions.append(((), Observable<PoductListDTO>.just(poductListDTO)))
      return Observable<PoductListDTO>.just(poductListDTO)
    } else {
      return Observable<PoductListDTO>.never()
    }
  }
}
