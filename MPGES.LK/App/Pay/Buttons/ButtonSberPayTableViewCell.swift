//
//  ButtonSberPayTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 10.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import UIKit
import SberPaySDK

class ButtonSberPayTableViewCell: UITableViewCell {
    
    var button: PayButton = {
        let payButton = PayButton()
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.cornerRadius = 8
        return payButton
    }()
    
    func configuration() {
        button.tapAction = onButtonTouch
        contentView.addSubview(button)
        //button.isEnabled = SberPay.isSberbankAppInstalled

        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    var onButtonTouch: (() -> Void) = {}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
