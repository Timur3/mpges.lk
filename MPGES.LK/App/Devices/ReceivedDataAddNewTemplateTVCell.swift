//
//  ReceivedDataAddNewTemplateTVCell.swift
//  mpges.lk
//
//  Created by Timur on 24.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataAddNewTemplateTVCell: UITableViewCell {

    @IBOutlet var previousReceivedDataLabel: UILabel!
    @IBOutlet var currentData: UITextField!
    @IBOutlet var tariffValue: UILabel!
    @IBOutlet var resultCalc: UILabel!
    
    func update(for model: ReceivedDataAddNewTemplateModel) {
        previousReceivedDataLabel.text = "\(model.previousReceivedData) кВт/час"
        tariffValue.text = "\(model.tariffValue) руб. * кВт/час"
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
