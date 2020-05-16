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
    
    func update(for invoice: InvoiceModel) {
        monthAndYearLabel.text = "\(invoice.month)-" + "\(invoice.year)"
        saldoLabel.text = formatRusCurrency(for: "\(invoice.saldo)")
        debetLabel.text = formatRusCurrency(for: "\(invoice.debet)")
        creditLabel.text = formatRusCurrency(for: "\(invoice.credit)")
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
