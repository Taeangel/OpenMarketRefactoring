//
//  ImageCollectionViewCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/16.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
  
  private var imageview: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  func bind(images: ProductImageEntity) {
    self.imageview.kf.setImage(with: images.imageURL)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    contentView.addSubview(imageview)
    
    NSLayoutConstraint.activate([
      imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
      imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
      imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
    ])
  }
}
