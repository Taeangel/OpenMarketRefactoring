//
//  ProductListCollectionViewCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import UIKit

class ListCell: UICollectionViewCell {
  static var identifier: String {
      return String(describing: self)
  }
  
  var productname: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .purple
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(productname)
    NSLayoutConstraint.activate([
      productname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      productname.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      productname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      productname.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
