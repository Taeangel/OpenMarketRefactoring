//
//  ProductListCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/14.
//

import UIKit
import Kingfisher

class ProductListCell: UICollectionViewCell {
  static var identifier: String {
    return String(describing: self)
  }
  
  private var imageview: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  private var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .leading
    stackView.axis = .vertical
    return stackView
  }()
  
  private var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 10)
    label.numberOfLines = 2
    return label
  }()
  
  private var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = .systemRed
    label.accessibilityPath?.stroke()
    return label
  }()
  
  private var discountedPriceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = .systemOrange
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
  
  func bind(_ product: ProductEntity) {
    self.imageview.kf.setImage(with: product.thumbnailURL)
    self.nameLabel.text = product.nameString
    self.descriptionLabel.text = product.descriptionString
    self.priceLabel.text = product.priceString
    self.discountedPriceLabel.text = product.discountedPriceString
  }
}

// MARK: - private
extension ProductListCell {
  private func configure() {
    contentView.addSubview(imageview)
    contentView.addSubview(stackView)
    
    stackView.addArrangeSubviews(nameLabel, descriptionLabel, priceLabel, discountedPriceLabel)
    
    NSLayoutConstraint.activate([
      imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
      imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      
      stackView.topAnchor.constraint(equalTo: imageview.bottomAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  private func setupLayout() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 10
    contentView.layer.cornerRadius = 20
    contentView.layer.masksToBounds = true
    contentView.backgroundColor = .white
  }
}
