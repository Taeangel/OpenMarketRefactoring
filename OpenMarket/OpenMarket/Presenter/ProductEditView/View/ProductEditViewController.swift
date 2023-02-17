//
//  ProductEditViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit

class ProductEditViewController: UIViewController {
  weak var coordinator: ProductEditViewCoordinator?
  private let viewModel : ProductEditViewModelable
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed

  }
  
  init(viewModel: ProductEditViewModelable) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
