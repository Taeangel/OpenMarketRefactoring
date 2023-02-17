//
//  ModiftViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import UIKit

class ProductModifyViewController: UIViewController {
  
  var viewModel: ProductModifyViewModelable
  weak var coordinator: ProductModifyCoordinator?
  
  init(viewModel: ProductModifyViewModelable) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(viewModel.productId)
  }
  
}
