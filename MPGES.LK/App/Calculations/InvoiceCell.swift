//
//  InvoiceCell.swift
//  mpges.lk
//
//  Created by Timur on 24.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoiceCellDelegate {
    func accessoryViewTapping(indexPath: IndexPath)
}

class InvoiceCell: UITableViewCell {

    func update(for invoice: InvoiceModel) {
        textLabel!.text = invoice.month?.name
        imageView?.image = UIImage(systemName: myImage.textPlus.rawValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
