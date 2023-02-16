//
//  ProductViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit
import RxCocoa
import RxSwift

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
  
  private var backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .systemRed
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return button
  }()
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  private var likeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.backgroundColor = .white
    return button
  }()
  
  private lazy var imageCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    bind()
  }
  
  func bind() {
    viewModel.images
      .bind(to: imageCollectionView.rx.items(
        cellIdentifier: ImageCollectionViewCell.identifier, cellType: ImageCollectionViewCell.self)) { index, item, cell in
          print(item.imageURL)
          cell.bind(images: item)
        }
        .disposed(by: disposeBag)
  }
  
  private func setup() {
    self.view.backgroundColor = .systemGray6
    
    self.view.addSubview(topStackView)
    self.view.addSubview(imageCollectionView)
    
    topStackView.addArrangeSubviews(backButton, titleLabel, likeButton)
    
    NSLayoutConstraint.activate([
      topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      
      imageCollectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
      imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      imageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
      
    ])
    
    viewModel.delegate = self
    
    backButton.tag = 100
  }
  
  @objc private func didTapButton(_ sender: UIButton) {
    viewModel.action(action: .buttonTap(sender.tag))
  }
  
  private func configureCollectionFlowLayout() -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.itemSize = CGSize(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
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

