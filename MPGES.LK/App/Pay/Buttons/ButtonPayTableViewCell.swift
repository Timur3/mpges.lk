//
//  ButtonTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 10.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit

class ButtonPayTableViewCell: UITableViewCell {
    
    var activityIndicator: UIActivityIndicatorView = {
        var ai = UIActivityIndicatorView()
        ai.style = .medium
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var button: UIButton = {
        var b = UIButton()
        b.setTitle("Оплатить", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isEnabled = true
        b.backgroundColor = yellowButtonColor()
        b.setImage(nil, for: .normal)
        b.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        return b
    }()
    
    var onButtonTouch: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
        print(button.state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        [button, activityIndicator].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            //indicator
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //button
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            button.widthAnchor.constraint(equalToConstant: 240),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        activityIndicator.stopAnimating()

        button.layer.cornerRadius = 8
        button.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        activityIndicator.stopAnimating()
        button.isEnabled = true
    }

    @objc func buttonTouchUpInside(_ sender: UIButton) {
        onButtonTouch?()
    }
    
    private static func yellowButtonColor() -> UIColor {
        return UIColor(red: 1, green: 0.867, blue: 0.176, alpha: 1)
    }
}
