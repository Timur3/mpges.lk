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

    func update(for pay: PaymentModel) {
        let sum: Double = (pay.summa)
        dataPay.text = pay.datePay
        sumPay.text = formatRusCurrency(for: "\(sum)")
        cashBox.text = pay.registerOfPayment?.typeOfPayment?.name
    }
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

}
