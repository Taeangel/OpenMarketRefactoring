//
//  FirstTabViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ProductListViewController: UIViewController {
  weak var coordinator: ProductListViewCoordinator?
  private var viewModel: ProductListViewModelable
  private var disposeBag = DisposeBag()
  
  init(viewModel: ProductListViewModelable) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: configureProductListLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      ProductListCell.self,
      forCellWithReuseIdentifier: ProductListCell.identifier
    )
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setup()
    bind()
  }
  override func viewWillAppear(_ animated: Bool) {
    viewModel.action(action: .updataList)
  }
  
  private func bind() {
    viewModel.productListObservable
      .bind(to: collectionView.rx.items(
        cellIdentifier: ProductListCell.identifier,
        cellType: ProductListCell.self)) { index, item, cell in
          cell.bind(item)
        }
        .disposed(by: disposeBag)
    
    collectionView.rx.modelSelected(BasicProductEntity.self)
      .subscribe(onNext: { [weak self] product in
        self?.viewModel.action(action: .productTap(product.intId))
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - Delegate

extension ProductListViewController: ProductListViewModelDelegate {
  func coordinatorShowProductView(productID: Int) {
    coordinator?.showProductViewController(productID)
  }
}
// MARK: - Layout

extension ProductListViewController {
  private func setup() {
    view.backgroundColor = .white
    
    self.tabBarController?.title = "OpenMarket"
    
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}

// MARK: - CollectionViewLayout
extension ProductListViewController {
  private func configureProductListLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { _, env in
      let width = (env.container.effectiveContentSize.width) * 0.5
      let height = width * 1.5
      
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .absolute(width),
        heightDimension: .absolute(height)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(height)
      )
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitems: [item]
      )
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
  }
}
