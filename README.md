# 🎁 OpenMarket 

#### Coordinator 적용한 이유
- 이전 프로젝트 에서 각각 다른 View 에서 동일한 View로 화면전환시 중복코드가 생겨나고, 각 다른 View에서 동일한 Class 인스턴스 를 주입받아야 하는 상황이 발생해 이를 해결하고자 Coordinator 패턴에 대해 공부하고 적용했습니다.
- Coordinator 패턴을 적용해 화면 전환 로직을 ViewController 에서 분리 하였고, ViewController 간의 의존성을 제거 하였습니다.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### 적용한 이유
- 기존 MVVM의 경우 MVC보다는 계층이 분리되고, 객체들의 관심사가 분리되지만 그럼에도 ViewModel의 역할이 커지는 문제가 발생했습니다.
- CleanArchitecture를 통해 Layer를 한층 더 나누어 주면서 계층별로 관심사가 나누어지게 되고, 자연스럽게 각각의 객체들의 역할이 나누어 지도록 하였습니다.
- 이로 인해 객체들의 결합도가 낮아지고, 응집도는 높아지면서 문제가 발생했을 때 쉽게 찾을 수 있고 해당 부분만 수정이 가능해지면서 유지보수적인 측면에서 상당한 이점을 갖을 수 있게 되었습니다.


### trobleShooting

- cocoapods Taraget 문제

```swift
def pods
  # Pods for OpenMarket
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay'
  pod 'SnapKit', '~> 5.6.0'
  pod 'Kingfisher', '~> 7.0'
end

target 'OpenMarket' do
  pods
end

target 'ProductRegistTest' do
  pods
end

target 'ProductEditTest' do
  pods
end
```
코코아팟은 이렇게 그 타겟에 필요한 라이브러리를 지정해주어야 된다..


#### cell 내부 버튼 RxSwift + MVVM
기존 방식은 coordinator와 viewModel을 cell에 전달해주에 cell내부에서 버튼에 바인딩하는 구조였다
하지만 이 구조는 MVVM의 접근제어자 문제와 유닛테스트에서 coodinator가 제대로 작동하는지 테스트가 불가능 했다
그래서 cell내부에서 @escaping 으로 밖으로 넘겨주고 밖에서 action 메서드로 전달해주어 MVVM 테스트가 용이해졌다

```swift
 private func bind() {
    viewModel.myProductListObservable
      .bind(to: collectionView.rx.items(
        cellIdentifier: MyProductCollectionViewCell.identifier,
        cellType: MyProductCollectionViewCell.self)) { index, item, cell in
          cell.bind(item)
          cell.bindButton(
            modifyButtontap: {
              self.viewModel.action(action: .modifyProductButtonTap(item.intId))
            },
            deleteButtontap: {
              self.viewModel.action(action: .deleteProductButtonTap(item.intId))
            }
          )
        }
        .disposed(by: disposeBag)
  }
}
```

#### MVVM의 ViewModel 테스트
기존 프로젝트에서는 뷰모델을 완벽히 뷰와분리하지 못하고 접근제어자 문제가 있어서 API Service 부분만따로 유닛테스트를 진행하였다.
이번 프로젝트에서는 testable한 viewModel을 만드는 것이 목표였기에 뷰에대한 action은 viewModel의 action메서드 하나로 처리 하도록 하여
testable한 viewModel을 구현하였다.

```swift
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

```
 

