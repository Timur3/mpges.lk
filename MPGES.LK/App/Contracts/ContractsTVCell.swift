//
//  ContractsTVCell.swift
//  mpges.lk
//
//  Created by Timur on 25.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractsTVCell: UITableViewCell {
    @IBOutlet weak var numberContract: UILabel!
    @IBOutlet weak var dateContract: UILabel!
    @IBOutlet weak var saldoContract: UILabel!
    @IBOutlet weak var contractorName: UILabel!
    
    var contract: ContractModel? {
        didSet {
            numberContract.text = contract?.number
            contractorName.text = contract?.contractorNameSmall
            dateContract.text = (contract?.dateRegister ?? "01-01-1970").replacingOccurrences(of: "T00:00:00", with: "")
            saldoContract.text = "100 руб"
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
