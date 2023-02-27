//
//  ModiftViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import UIKit
import RxSwift
import RxCocoa

class ProductModifyViewController: UIViewController {
  
  var viewModel: ProductModifyViewModelable
  weak var coordinator: ProductModifyCoordinator?
  private var disposeBag: DisposeBag
  
  init(viewModel: ProductModifyViewModelable) {
    self.viewModel = viewModel
    self.disposeBag = .init()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private lazy var imageCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: setupImageViewLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemGray6
    collectionView.register(
      ImageCollectionViewCell.self,
      forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
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
    return textField
  }()
  
  private let priceTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    return textField
  }()
  
  private let discountedPriceTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    return textField
  }()
  
  private let stockTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    return textField
  }()
  
  private let descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.keyboardType = .numberPad
    return textField
  }()
  
  lazy var updataButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .white
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 10
    button.setTitle("상품 수정", for: .normal)
    button.setTitleColor(.systemGray3, for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    coordinator?.dismiss()
  }
  
  private func bind() {
    
    // MARK: - Output
    nameTextField.rx.text.orEmpty
      .bind(to: viewModel.nameObserable)
      .disposed(by: disposeBag)
    
    priceTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .bind(to: viewModel.priceObserable)
      .disposed(by: disposeBag)
    
    discountedPriceTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .bind(to: viewModel.discountPriceObserable)
      .disposed(by: disposeBag)
    
    stockTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .bind(to: viewModel.stockPriceObserable)
      .disposed(by: disposeBag)
    
    descriptionTextField.rx.text.orEmpty
      .bind(to: viewModel.descriptionObserable)
      .disposed(by: disposeBag)
    
    updataButton.rx.tap
      .withUnretained(self)
      .bind { _, _ in
        self.viewModel.modiftProduct()
        self.coordinator?.dismiss()
      }
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.nameString }
      .bind(to: nameTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.priceString }
      .bind(to: priceTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.discountedPriceString }
      .bind(to: discountedPriceTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.stockString }
      .bind(to: stockTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.descriptionString }
      .bind(to: descriptionTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .map { $0.arrayImages }
      .bind(to: imageCollectionView.rx.items(
        cellIdentifier: ImageCollectionViewCell.identifier,
        cellType: ImageCollectionViewCell.self)) { index, item, cell in
          cell.bind(images: item)
        }
        .disposed(by: disposeBag)
  }
}

// MARK: - Layout
extension ProductModifyViewController {
  private func setup() {
    view.backgroundColor = .systemGray6
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
      
      imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
      imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      imageCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
      
      productInfoStackView.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 20),
      productInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      productInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      updataButton.topAnchor.constraint(equalTo: productInfoStackView.bottomAnchor, constant: 20),
      updataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      updataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])
  }
}

// MARK: - CollectionViewLayout

extension ProductModifyViewController {
  private func setupImageViewLayout() -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.itemSize = CGSize(
      width: UIScreen.main.bounds.width * 0.6,
      height: UIScreen.main.bounds.width * 0.6
    )
    flowLayout.minimumLineSpacing = 16
    flowLayout.scrollDirection = .horizontal
    
    return flowLayout
  }
}
