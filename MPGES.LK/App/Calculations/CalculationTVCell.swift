//
//  CalculationTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class CalculationTVCell: UITableViewCell {
    @IBOutlet var calcDateLabel: UILabel!
    @IBOutlet var calcTypeOfCalculationLabel: UILabel!
    
    @IBOutlet var calcSumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(for calc: CalculationModel){
        calcDateLabel.text = calc.date
        calcTypeOfCalculationLabel.text = calc.typeOfCalculation.name
        calcSumLabel.text = formatRusCurrency(calc.summa)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
