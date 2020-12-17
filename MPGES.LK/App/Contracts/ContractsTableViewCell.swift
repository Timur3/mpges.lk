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
    @IBOutlet weak var contractAddress: UILabel!
    
    func update(for contract: ContractModel) {
        let conNum = "\(contract.id)"
        numberContract.text = conNum
        contractTypeName.text = contract.typeOfContract.name
        contractAddress.text = contract.primaryAddress
           DispatchQueue.main.async { [weak self] in
               guard self != nil else { return }
            ApiServiceWrapper.shared.loadSaldoContract(id: contract.id, label: self!.saldoContract)
           }
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.layer.shadowRadius = 10
//        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
