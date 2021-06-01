//
//  DevileryOfInvoiceTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class DeliveryOfInvoiceTableViewCell: UITableViewCell {
    
    static let identifier = "deliveryOfInvoiceCell"
    
    func update(for model: InvoiceDeliveryMethodModel) {
        textLabel?.text = model.devileryMethodName
        detailTextLabel?.text = model.description
        imageView?.image = UIImage(systemName: myImage.mail.rawValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel?.linesCornerRadius = 5
        detailTextLabel?.linesCornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
