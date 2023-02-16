//
//  ProductViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ProductViewController: UIViewController {
  weak var coordinator: ProductViewCoordinator?
  var viewModel: ProductViewModel
  private var disposeBag: DisposeBag
  
  init(viewModel: ProductViewModel) {
    self.viewModel = viewModel
    self.disposeBag = .init()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var topStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    return stackView
  }()
  
  private lazy var imageCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: configureCollectionFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      ImageCollectionViewCell.self,
      forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    collectionView.backgroundColor = .systemGray6
    return collectionView
  }()
  
  var registerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.text = "등록자"
    label.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal)
    return label
  }()
  
  var infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillProportionally
    stackView.spacing = 5
    stackView.axis = .vertical
    return stackView
  }()
  
  var productLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "상품정보"
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "가격"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .systemGray3
    label.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal)
    return label
  }()
  
  var discountedPriceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "할인가"
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal)
    return label
  }()
  
  var stockLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "수량"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .systemGray3
    return label
  }()
  
  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "설명"
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    coordinator?.dismiss()
  }
  
  func bind() {
    viewModel.productObservable.map { $0.arrayImages }
      .bind(to: imageCollectionView.rx.items(
        cellIdentifier: ImageCollectionViewCell.identifier,
        cellType: ImageCollectionViewCell.self)) { index, item, cell in
          cell.bind(images: item)
        }
        .disposed(by: disposeBag)
      
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.name }
      .subscribe(onNext: { [weak self] productTitle in
        self?.title = productTitle
      })
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.vendors?.name }
      .bind(to: self.registerLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.name }
      .bind(to: self.productLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.priceString }
      .bind(to: self.priceLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.discountedPriceString }
      .bind(to: self.discountedPriceLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.stockString }
      .bind(to: self.stockLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.productObservable
      .catchAndReturn(DetailProductEneity())
      .observe(on: MainScheduler.instance)
      .map { $0.descriptionString }
      .bind(to: self.descriptionLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func setup() {
    self.view.backgroundColor = .systemGray6

    self.view.addSubview(imageCollectionView)
    self.view.addSubview(infoStackView)
    self.view.addSubview(descriptionLabel)
    
    infoStackView.addArrangeSubviews(
      
      registerLabel,
      DividerLineView(),
      productLabel,
      priceLabel,
      discountedPriceLabel,
      stockLabel,
      DividerLineView()
    )

    NSLayoutConstraint.activate([
      
      imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

      imageCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
      imageCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor),
      
      
      infoStackView.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor ,constant: 10),
      infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
      infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),

      descriptionLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor,constant: 10),
      descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
    ])
    
    viewModel.delegate = self
  }
  
  @objc private func didTapButton(_ sender: UIButton) {
    viewModel.action(action: .buttonTap(sender.tag))
  }
  
  private func configureCollectionFlowLayout() -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.itemSize = CGSize(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height * 0.8
    )
    flowLayout.minimumLineSpacing = 0
    flowLayout.scrollDirection = .horizontal
    
    return flowLayout
  }
}

extension ProductViewController: ProductViewModelDelegate {
  func dismiss() {
    coordinator?.dismiss()
  }
}

