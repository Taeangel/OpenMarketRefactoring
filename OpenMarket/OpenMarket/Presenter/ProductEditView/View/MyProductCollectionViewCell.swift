//
//  MyProductCollectionViewCell.swift
//  OpenMarket
//
//  Created by song on 2023/02/17.
//

import UIKit

class MyProductCollectionViewCell: UICollectionViewCell {
  private let productimageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  private let infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    return stackView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  
  private let priceStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis =  .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .red
    return label
  }()
  
  private let discountPriceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.textColor = .orange
    return label
  }()
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 3
    return stackView
  }()
  
  let deleteButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .red
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 10.0
    button.setTitle(" 삭제 ", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitle("수정", for: .highlighted)
    button.setTitleColor(.black, for: .highlighted)
    return button
  }()
  
  let modifyButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .orange
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 10.0
    button.setTitle(" 수정 ", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitle("수정", for: .highlighted)
    button.setTitleColor(.black, for: .highlighted)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(_ product: BasicProductEntity) {
    self.productimageView.kf.setImage(with: product.thumbnailURL)
    self.nameLabel.text = product.nameString
    self.descriptionLabel.text = product.descriptionString
    self.priceLabel.text = product.priceString
    self.discountPriceLabel.text = product.discountedPriceString
  }
  
  private func setupLayout() {
    layer.shadowRadius = 10
    contentView.layer.cornerRadius = 20
    contentView.layer.masksToBounds = true
    contentView.backgroundColor = .white
  }
  
  private func setup() {
    contentView.addSubview(productimageView)
    contentView.addSubview(infoStackView)
    contentView.addSubview(priceStackView)
    
    infoStackView.addArrangeSubviews(nameLabel, descriptionLabel)
    priceStackView.addArrangeSubviews(priceLabel, discountPriceLabel)
    
    NSLayoutConstraint.activate([
      productimageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      productimageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
      productimageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      productimageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
      
      infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      infoStackView.leadingAnchor.constraint(equalTo: productimageView.trailingAnchor, constant: 10),
      infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      
      priceStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 10),
      priceStackView.leadingAnchor.constraint(equalTo: productimageView.trailingAnchor, constant: 10),
      priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    ])
  }
}
