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
    
    static let identifier = "paymentCell"
    
    func update(for pay: PaymentModel) {
        let sum: Decimal = (pay.summa)
        datePay.text = pay.datePay
        sumPay.text = formatRusCurrency(sum)
        cashBox.text = pay.registerOfPayment?.typeOfPayment?.name
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // for skeletonView
        datePay.linesCornerRadius = 5
        sumPay.linesCornerRadius = 5
        cashBox.linesCornerRadius = 5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func payCellAction(tapGestureRecognizer: UITapGestureRecognizer) {
        
    }
    
}
