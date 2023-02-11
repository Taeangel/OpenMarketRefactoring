//
//  ViewController.swift
//  OpenMarketUIkit
//
//  Created by song on 2023/02/11.
//

import UIKit

class MainViewController: UITableViewController {
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
  }
}
