//
//  FirstTabViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit
import RxCocoa
import RxSwift

class ProductListViewController: UIViewController {
  weak var coodinator: ProductListViewCoordinator?
  var viewModel: ProductListViewModelable

  init(viewModel: ProductListViewModelable) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }
}
