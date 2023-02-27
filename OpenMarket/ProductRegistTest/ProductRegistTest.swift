//
//  ProductRegistTest.swift
//  ProductRegistTest
//
//  Created by song on 2023/02/27.
//

import XCTest
import RxSwift
@testable import OpenMarket

final class ProductRegistTest: XCTestCase {
  
  var viewModel: ProductRegisterViewModelStub!
  var delegate: ProductRegisterViewModelDelegateStub!
  var usecase: RegisterUsecaseStub!
  
  override func setUp() {
    super.setUp()
    reset()
    
  }
  
  func reset() {
    usecase = RegisterUsecaseStub()
    delegate = ProductRegisterViewModelDelegateStub()
    viewModel = ProductRegisterViewModelStub(registerUseCase: usecase)
  }
  
  func test_상품등록버튼_눌림() {
    viewModel.action(action: .buttonTap(100))//100번이 상품등록 버튼임
    
    XCTAssertTrue({
      guard case .buttonTap = viewModel.buttonActionExcutions[0].0 else {
        return false
      }
      return true
    }())
  }
  
  func test_이미지저장버튼_작동() {
    viewModel.action(action: .saveImage(UIImage(systemName: "heart")!))
    
    XCTAssertTrue({
      guard case .saveImage = viewModel.buttonActionExcutions[0].0 else {
        return false
      }
      return true
    }())
  }
  
  func test_이미지추가버튼_눌림() {
    //given
    let mockModel = ProductRequestDTO(
      name: "목",
      description: "테스트용",
      price: 0,
      currency: "KRW",
      discountedPrice: 0,
      stock: 0)
    
    usecase.productRequestDTO = mockModel
    
    //when
    viewModel.action(action: .buttonTap(100))
    
    
    //then
    XCTAssertTrue({
      guard case .buttonTap = viewModel.buttonActionExcutions[0].0 else {
        return false
      }
      return true
    }())
    XCTAssertEqual(usecase.callAPIExcutions.count, 1)
    XCTAssertNoThrow(usecase.postProduct(params: mockModel, images: [Data()]))
  }
}


class ProductRegisterViewModelStub: ProductRegisterViewModel {
  var buttonActionExcutions: [(ProductRegisterViewModel.ViewAction, Void)] = []
  override func action(action: ProductRegisterViewModel.ViewAction) {
    buttonActionExcutions.append((action, ()))
    super.action(action: action)
  }
}

class ProductRegisterViewModelDelegateStub: RegistetViewModelDelegate {
  
  var coordinatorImagePickerExcutions: [Void] = []
  func coordinatorImagePicker() {
    coordinatorImagePickerExcutions.append(())
  }
}

class RegisterUsecaseStub: RegisterUseCaseable {
  
  enum apiError: Error {
    case notWork
  }
  
  var callAPIExcutions: [((ProductRequestDTO, [Data]), Observable<Void>)] = []
  var productRequestDTO: ProductRequestDTO?
  var error = apiError.notWork
  
  func postProduct(params: ProductRequestDTO, images: [Data]) -> Observable<Void> {
    
    if productRequestDTO == nil {
      return Observable<Void>.error(error)
    } else {
      callAPIExcutions.append(((params, images), (Observable<Void>.just(()))))
      return Observable<Void>.never()
    }
  }
}
