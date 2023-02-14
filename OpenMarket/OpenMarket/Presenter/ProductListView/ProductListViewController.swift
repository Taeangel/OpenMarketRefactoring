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
  
  private var disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue

  }
}
