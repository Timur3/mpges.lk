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
    @IBOutlet weak var contractTypeName: UILabel!
    @IBOutlet weak var saldoContract: UILabel!
    
    func update(for contract: ContractModel) {
        let conNum = "\(contract.id)"
        numberContract.text =  "#"+conNum
        contractTypeName.text = contract.typeOfContract.name
           DispatchQueue.main.async { [weak self] in
               guard self != nil else { return }
            ApiServiceAdapter.shared.loadSaldoContract(id: contract.id, label: self!.saldoContract)
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
