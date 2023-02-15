//
//  UIStackViewExtension.swift
//  OpenMarket
//
//  Created by song on 2023/02/15.
//

import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
