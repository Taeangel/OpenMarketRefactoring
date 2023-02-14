//
//  SecondTabViewController.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class ProductRegisterViewController: UIViewController {
  weak var coordinator: ProductRegisterViewCoordinator?
  private let viewModel: ProductRegisterViewModelable
  
  init( viewModel: ProductRegisterViewModelable) {
    self.viewModel = viewModel
    super .init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
}
