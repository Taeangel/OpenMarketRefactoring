//
//  AddImageCollectionViewCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/16.
//

import UIKit
import SnapKit

class AddImageCollectionViewCell: UICollectionViewCell {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .systemGray6
    imageView.layer.borderColor = UIColor.systemGray3.cgColor
    imageView.layer.cornerRadius = 5
    imageView.layer.borderWidth = 0.5
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(image: UIImage) {
    self.imageView.image = image
  }
  
  private func setup() {
    contentView.addSubview(imageView)
    imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}


