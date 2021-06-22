//
//  DevileryOfInvoiceTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class InvoiceDeliveryMethodsTableViewCell: UITableViewCell {
    
    static let identifier = "invoiceDeliveryMethodsCell"
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(model) {
            guard let model = model else { return }
            textLabel?.text = model.textLabel
            detailTextLabel?.text = model.detailTextLabel
            imageView?.image = model.image
        }
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
