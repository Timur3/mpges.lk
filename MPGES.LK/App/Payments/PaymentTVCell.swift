//
//  PaymentTVCell.swift
//  mpges.lk
//
//  Created by Timur on 14.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PaymentTVCell: UITableViewCell {
    @IBOutlet weak var datePay: UILabel!
    @IBOutlet weak var sumPay: UILabel!
    @IBOutlet weak var cashBox: UILabel!

    func update(for pay: PaymentModel) {
        let sum: Double = (pay.summa)
        datePay.text = pay.datePay
        sumPay.text = formatRusCurrency(sum)
        cashBox.text = pay.registerOfPayment?.typeOfPayment?.name
    }
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func payCellAction(tapGestureRecognizer: UITapGestureRecognizer) {
        
    }
    
}
