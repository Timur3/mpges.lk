//
//  InvoiceTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 29.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class InvoiceTVCell: UITableViewCell {
    
    @IBOutlet weak var monthAndYearLabel: UILabel!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var debetLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    var invoices: InvoiceModel? {
        didSet {
            monthAndYearLabel.text = "\(invoices?.month)" + "\(invoices?.year)"
            saldoLabel.text = "\(String(describing: invoices?.saldo))"
            debetLabel.text = "\(invoices?.debet)"
            creditLabel.text = "\(invoices?.credit)"
        }
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
