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
    return imageView
  }()
  
  func bind(images: ProductImageEntity) {
    print(images.imageURL)
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
      imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
      imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
      imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  private func setupLayout() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 10
    contentView.backgroundColor = .white
  }
}
