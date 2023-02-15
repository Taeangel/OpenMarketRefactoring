//
//  ProductListCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import UIKit

class ProductListCell: UICollectionViewCell {
  static var identifier: String {
    return String(describing: self)
  }
  
  var productname: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure() {
    contentView.addSubview(productname)
    
    NSLayoutConstraint.activate([
      productname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      productname.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      productname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      productname.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  func setupLayout() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 10
    contentView.layer.cornerRadius = 20
    contentView.layer.masksToBounds = true
    contentView.backgroundColor = .systemPink
  }
}
