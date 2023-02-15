//
//  ProductViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit

class ProductViewController: UIViewController {
  weak var coordinator: ProductViewCoordinator?
  var viewModel: ProductViewModel
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
  }
  
  init(viewModel: ProductViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
