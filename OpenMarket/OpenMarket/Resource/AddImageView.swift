//
//  AddImageView.swift
//  OpenMarket
//
//  Created by song on 2023/02/16.
//

import UIKit
import SnapKit


final class EnableStackView: UIStackView {
  override func hitTest(
    _ point: CGPoint,
    with event: UIEvent?
  ) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    if self == hitView { return nil }
    return hitView
  }
}

final class ImageButton: UIButton {
    
  private let mainStackView: EnableStackView = {
    let stackView = EnableStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 0
    return stackView
  }()
  
  private let addImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "camera")
    imageView.tintColor = .systemGray3
    return imageView
  }()
  
  var imageCountLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    label.textColor = .systemGray3
    return label
  }()
  
  init() {
    super.init(frame: .zero)
    configureView()
    configureConstraints()
    configureButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureButton() {
    layer.borderWidth = 2
    layer.cornerRadius = 8
    layer.borderColor = UIColor.systemGray3.cgColor
    backgroundColor = .systemBackground
    clipsToBounds = true
  }
  
  private func configureView() {
    addSubview(mainStackView)
    mainStackView.addArrangedSubview(addImageView)
    mainStackView.addArrangedSubview(imageCountLabel)
  }
  
  private func configureConstraints() {
    mainStackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(18)
    }
    
    addImageView.snp.makeConstraints {
      $0.height.width.equalToSuperview().multipliedBy(0.2)
    }
  }
}
