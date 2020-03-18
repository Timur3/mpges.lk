//
//  PaymentTVCell.swift
//  mpges.lk
//
//  Created by Timur on 14.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PaymentTVCell: UITableViewCell {
    @IBOutlet weak var dataPay: UILabel!
    @IBOutlet weak var sumPay: UILabel!
    @IBOutlet weak var cashBox: UILabel!
        
    var payment: PaymentModel? {
        didSet {
            let sum: Double = (payment?.summa ?? 0.00)
                
                dataPay.text = (payment?.datePay ?? "01-01-1970").replacingOccurrences(of: "T00:00:00", with: "")
                sumPay.text = "\(sum)"
                cashBox.text = payment?.cash
            }
    }
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

}
