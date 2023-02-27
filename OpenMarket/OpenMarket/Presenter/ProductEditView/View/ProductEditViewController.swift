//
//  ProductEditViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit
import RxCocoa
import RxSwift

class ProductEditViewController: UIViewController {
  private var disposeBag: DisposeBag
  weak var coordinator: ProductEditViewCoordinator?
  private var viewModel: ProductEditViewModelable
  init(viewModel: ProductEditViewModelable) {
    self.viewModel = viewModel
    self.disposeBag = .init()
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
      MyProductCollectionViewCell.self,
      forCellWithReuseIdentifier: MyProductCollectionViewCell.identifier
    )
    collectionView.backgroundColor = .systemGray6
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setup()
    bind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.action(action: .updateList)
  }
  
  private func bind() {
    viewModel.myProductListObservable
      .bind(to: collectionView.rx.items(
        cellIdentifier: MyProductCollectionViewCell.identifier,
        cellType: MyProductCollectionViewCell.self)) { index, item, cell in
          cell.bind(item)
          cell.bindButton(
            modifyButtontap: {
              self.viewModel.action(action: .ModifyProductButtonTap(item.intId))
            },
            deleteButtontap: {
              self.viewModel.action(action: .deleteProductButtonTap(item.intId))
            }
          )
        }
        .disposed(by: disposeBag)
  }
}

// MARK: - Delegate
extension ProductEditViewController: ProductEditViewModelDelegate {
  func coordinatorShowModifyView(_ productID: Int) {
    coordinator?.showProductModifyViewController(productID)
  }
}


// MARK: - layout

extension ProductEditViewController {
  private func setup() {
    view.backgroundColor = .systemGray6
    
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
extension ProductEditViewController {
  private func configureProductListLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { _, env in
      let width = (env.container.effectiveContentSize.width)
      let height = width * 0.4
      
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
