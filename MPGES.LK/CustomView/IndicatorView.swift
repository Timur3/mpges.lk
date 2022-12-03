//
//  IndicatorView.swift
//  mpges.lk
//
//  Created by Timur on 20.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit

final class IndicatorView: UIView {
    
    private let stackViewVertical: UIStackView = {
        let edgeInset: CGFloat = 8
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.backgroundColor = UIColor.init(_colorLiteralRed: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5)
        sv.isLayoutMarginsRelativeArrangement = true
        sv.layer.cornerRadius = 8.0
        return sv
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        var i = UIActivityIndicatorView(style: .large)
        i.startAnimating()
        i.center = self.center
        return i
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(indicator)

        
        NSLayoutConstraint.activate([
            stackViewVertical.heightAnchor.constraint(equalToConstant: 70),
            stackViewVertical.widthAnchor.constraint(equalToConstant: 70),
            stackViewVertical.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackViewVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
