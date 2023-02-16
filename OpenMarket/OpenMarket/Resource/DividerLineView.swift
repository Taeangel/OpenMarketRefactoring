//
//  DividerLineView.swift
//  OpenMarket
//
//  Created by song on 2023/02/16.
//

import UIKit

final class DividerLineView: UIView {
    init(height: CGFloat = 1.0) {
        super.init(frame: .zero)
        
        configureLayout(height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout(_ height: CGFloat) {
        backgroundColor = .systemGray3
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
