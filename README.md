# ๐ OpenMarket 

#### Coordinator ์ ์ฉํ ์ด์ 
- ์ด์  ํ๋ก์ ํธ ์์ ๊ฐ๊ฐ ๋ค๋ฅธ View ์์ ๋์ผํ View๋ก ํ๋ฉด์ ํ์ ์ค๋ณต์ฝ๋๊ฐ ์๊ฒจ๋๊ณ , ๊ฐ ๋ค๋ฅธ View์์ ๋์ผํ Class ์ธ์คํด์ค ๋ฅผ ์ฃผ์๋ฐ์์ผ ํ๋ ์ํฉ์ด ๋ฐ์ํด ์ด๋ฅผ ํด๊ฒฐํ๊ณ ์ Coordinator ํจํด์ ๋ํด ๊ณต๋ถํ๊ณ  ์ ์ฉํ์ต๋๋ค.
- Coordinator ํจํด์ ์ ์ฉํด ํ๋ฉด ์ ํ ๋ก์ง์ ViewController ์์ ๋ถ๋ฆฌ ํ์๊ณ , ViewController ๊ฐ์ ์์กด์ฑ์ ์ ๊ฑฐ ํ์์ต๋๋ค.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### ์ ์ฉํ ์ด์ 
- ๊ธฐ์กด MVVM์ ๊ฒฝ์ฐ MVC๋ณด๋ค๋ ๊ณ์ธต์ด ๋ถ๋ฆฌ๋๊ณ , ๊ฐ์ฒด๋ค์ ๊ด์ฌ์ฌ๊ฐ ๋ถ๋ฆฌ๋์ง๋ง ๊ทธ๋ผ์๋ ViewModel์ ์ญํ ์ด ์ปค์ง๋ ๋ฌธ์ ๊ฐ ๋ฐ์ํ์ต๋๋ค.
- CleanArchitecture๋ฅผ ํตํด Layer๋ฅผ ํ์ธต ๋ ๋๋์ด ์ฃผ๋ฉด์ ๊ณ์ธต๋ณ๋ก ๊ด์ฌ์ฌ๊ฐ ๋๋์ด์ง๊ฒ ๋๊ณ , ์์ฐ์ค๋ฝ๊ฒ ๊ฐ๊ฐ์ ๊ฐ์ฒด๋ค์ ์ญํ ์ด ๋๋์ด ์ง๋๋ก ํ์์ต๋๋ค.
- ์ด๋ก ์ธํด ๊ฐ์ฒด๋ค์ ๊ฒฐํฉ๋๊ฐ ๋ฎ์์ง๊ณ , ์์ง๋๋ ๋์์ง๋ฉด์ ๋ฌธ์ ๊ฐ ๋ฐ์ํ์ ๋ ์ฝ๊ฒ ์ฐพ์ ์ ์๊ณ  ํด๋น ๋ถ๋ถ๋ง ์์ ์ด ๊ฐ๋ฅํด์ง๋ฉด์ ์ ์ง๋ณด์์ ์ธ ์ธก๋ฉด์์ ์๋นํ ์ด์ ์ ๊ฐ์ ์ ์๊ฒ ๋์์ต๋๋ค.


### trobleShooting

- cocoapods Taraget ๋ฌธ์ 

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
์ฝ์ฝ์ํ์ ์ด๋ ๊ฒ ๊ทธ ํ๊ฒ์ ํ์ํ ๋ผ์ด๋ธ๋ฌ๋ฆฌ๋ฅผ ์ง์ ํด์ฃผ์ด์ผ ๋๋ค..


#### cell ๋ด๋ถ ๋ฒํผ RxSwift + MVVM
๊ธฐ์กด ๋ฐฉ์์ coordinator์ viewModel์ cell์ ์ ๋ฌํด์ฃผ์ cell๋ด๋ถ์์ ๋ฒํผ์ ๋ฐ์ธ๋ฉํ๋ ๊ตฌ์กฐ์๋ค
ํ์ง๋ง ์ด ๊ตฌ์กฐ๋ MVVM์ ์ ๊ทผ์ ์ด์ ๋ฌธ์ ์ ์ ๋ํ์คํธ์์ coodinator๊ฐ ์ ๋๋ก ์๋ํ๋์ง ํ์คํธ๊ฐ ๋ถ๊ฐ๋ฅ ํ๋ค
๊ทธ๋์ cell๋ด๋ถ์์ @escaping ์ผ๋ก ๋ฐ์ผ๋ก ๋๊ฒจ์ฃผ๊ณ  ๋ฐ์์ action ๋ฉ์๋๋ก ์ ๋ฌํด์ฃผ์ด MVVM ํ์คํธ๊ฐ ์ฉ์ดํด์ก๋ค

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

#### MVVM์ ViewModel ํ์คํธ
๊ธฐ์กด ํ๋ก์ ํธ์์๋ ๋ทฐ๋ชจ๋ธ์ ์๋ฒฝํ ๋ทฐ์๋ถ๋ฆฌํ์ง ๋ชปํ๊ณ  ์ ๊ทผ์ ์ด์ ๋ฌธ์ ๊ฐ ์์ด์ API Service ๋ถ๋ถ๋ง๋ฐ๋ก ์ ๋ํ์คํธ๋ฅผ ์งํํ์๋ค.
์ด๋ฒ ํ๋ก์ ํธ์์๋ testableํ viewModel์ ๋ง๋๋ ๊ฒ์ด ๋ชฉํ์๊ธฐ์ ๋ทฐ์๋ํ action์ viewModel์ action๋ฉ์๋ ํ๋๋ก ์ฒ๋ฆฌ ํ๋๋ก ํ์ฌ
testableํ viewModel์ ๊ตฌํํ์๋ค.

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
    // validID๊ฐ 10 ์ด์์ด๋ฉด ์๋ง์ ID๋ผ๊ณ  ๊ฐ์ 
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
 

