//
//  ContractsTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractsTableViewCell: UITableViewCell {
    @IBOutlet weak var numberContract: UILabel!
       @IBOutlet weak var dateContract: UILabel!
       @IBOutlet weak var saldoContract: UILabel!
       @IBOutlet weak var contractorName: UILabel!
       
       var contract: ContractModel? {
           didSet {
               numberContract.text = contract?.number
               contractorName.text = contract?.contractorNameSmall
               dateContract.text = (contract?.dateRegister ?? "01-01-1970").replacingOccurrences(of: "T00:00:00", with: "")
               DispatchQueue.main.async { [weak self] in
                   guard self != nil else { return }
                   ApiServiceAdapter.shared.loadSaldoContract(id: self!.contract!.id, label: self!.saldoContract)
               }
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
