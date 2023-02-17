//
//  SecondTabViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit
import RxCocoa
import RxSwift

class ProductRegisterViewController: UIViewController {
  weak var coordinator: ProductRegisterViewCoordinator?
  private let viewModel: ProductRegisterViewModelable
  private var disposeBag: DisposeBag
  init(viewModel: ProductRegisterViewModelable) {
    self.viewModel = viewModel
    self.disposeBag = .init()
    super .init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let imageStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 16
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    return stackView
  }()
  
  private lazy var addImageButton: ImageButton = {
    let addImageButton = ImageButton()
    addImageButton.translatesAutoresizingMaskIntoConstraints = false
    return addImageButton
  }()
  
  private lazy var imageCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: setupImageViewLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemGray6
    collectionView.register(
      AddImageCollectionViewCell.self,
      forCellWithReuseIdentifier: AddImageCollectionViewCell.identifier)
    return collectionView
  }()
  
  private let productInfoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 2
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    stackView.backgroundColor = .white
    stackView.clipsToBounds = true
    
    return stackView
  }()
  
  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .default
    textField.placeholder = "상품이름"
    return textField
  }()
  
  private let priceTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    textField.placeholder = "가격"
    return textField
  }()
  
  private let discountedPriceTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    textField.placeholder = "할인가"
    return textField
  }()
  
  private let stockTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    textField.placeholder = "상품 수량"
    return textField
  }()
  
  private let descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    textField.placeholder = "설명"
    return textField
  }()
  
  private lazy var imagePicker: UIImagePickerController = {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
    return imagePicker
  }()
  
  lazy var updataButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .white
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 10
    button.setTitle("상품등록", for: .normal)
    button.setTitleColor(.systemGray3, for: .normal)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
    addImageButtonBind()
    registerProductbuttonBind()
  }
  
  func bind() {
    viewModel.imagesObserable
      .bind(to: imageCollectionView.rx.items(
        cellIdentifier: AddImageCollectionViewCell.identifier,
        cellType: AddImageCollectionViewCell.self)) { index, item, cell in
          print(item)
          cell.bind(image: item)
        }
        .disposed(by: disposeBag)
    
    addImageButton.rx.tap
      .withUnretained(self)
      .bind { vc, _ in
        vc.coordinator?.showPhotoLibrary(to: self.imagePicker)
      }
      .disposed(by: disposeBag)
    
    viewModel.imageCountObserable
      .map { "\($0)/5" }
      .catchAndReturn("")
      .observe(on: MainScheduler.instance)
      .subscribe { [weak self] text in
        self?.addImageButton.imageCountLabel.text = text
      }
      .disposed(by: disposeBag)
  }
  
  func addImageButtonBind() {
    viewModel.imageCountObserable
      .map { $0 < 5 }
      .bind(to: addImageButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
  func registerProductbuttonBind() {
    let nameTextObserable = nameTextField.rx.text
      .map { $0 == "" }

    let priceTextObserable = priceTextField.rx.text
      .compactMap { $0 }
      .compactMap { Int($0) }
      
    let discountedPriceObserable = discountedPriceTextField.rx.text
      .compactMap { $0 }
      .compactMap { Int($0) }
      
    let priceObserable = BehaviorRelay.combineLatest(priceTextObserable, discountedPriceObserable)
      .map { $0 > $1 }

    let stockTextObserable =  stockTextField.rx.text
      .compactMap { $0 }
      .compactMap { Int($0) }
      .map { $0 > 0}

    let descriptionTextObserable = descriptionTextField.rx.text
      .map { $0 == "" }
    
    Observable.combineLatest(
      nameTextObserable,
      priceObserable,
      stockTextObserable,
      descriptionTextObserable
    ) { $0 && $1 && $2 && $3 }
      .bind(to: updataButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
  func setup() {
    view.backgroundColor = .systemGray6
    view.addSubview(addImageButton)
    view.addSubview(imageCollectionView)
    view.addSubview(productInfoStackView)
    view.addSubview(updataButton)
    
    productInfoStackView.addArrangeSubviews(
      nameTextField,
      priceTextField,
      discountedPriceTextField,
      stockTextField,
      descriptionTextField
    )
    
    NSLayoutConstraint.activate([
      
      addImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      addImageButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
      addImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
      
      imageCollectionView.topAnchor.constraint(equalTo: addImageButton.topAnchor),
      imageCollectionView.leadingAnchor.constraint(equalTo: addImageButton.trailingAnchor, constant: 10),
      imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      imageCollectionView.heightAnchor.constraint(equalTo: addImageButton.heightAnchor),
      
      productInfoStackView.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 20),
      productInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      productInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      updataButton.topAnchor.constraint(equalTo: productInfoStackView.bottomAnchor, constant: 20),
      updataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      updataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])
  }
  
  private func setupImageViewLayout() -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.itemSize = CGSize(
      width: UIScreen.main.bounds.width * 0.3,
      height: UIScreen.main.bounds.width * 0.3
    )
    flowLayout.minimumLineSpacing = 16
    flowLayout.scrollDirection = .horizontal
    
    return flowLayout
  }
}

extension ProductRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo
    info: [UIImagePickerController.InfoKey : Any]
  ) {
    if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      guard let resizedPickerImage = resize(image: image, newWidth: 300) else {
        return
      }
      viewModel.appendImage(image: resizedPickerImage)
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  private func resize(image: UIImage, newWidth: CGFloat) -> UIImage? {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
}
