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
       @IBOutlet weak var contractName: UILabel!
       @IBOutlet weak var saldoContract: UILabel!

       
       var contract: ContractModel? {
           didSet {
            let conNum = "\(contract?.id ?? 0)"
            numberContract.text =  "#"+conNum
               contractName.text = contract?.contractName
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
