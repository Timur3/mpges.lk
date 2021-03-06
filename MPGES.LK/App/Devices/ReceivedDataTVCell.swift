//
//  ReceivedDataTVCell.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataTVCell: UITableViewCell {
    
    @IBOutlet weak var receivedDataDateLabel: UILabel!
    @IBOutlet weak var tariffZoneLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier = "receivedDataCell"
    
    func update(for receivedData: ReceivedDataModel) {
        receivedDataDateLabel.text = receivedData.date
        valueLabel.text = "\(receivedData.value) кВт/час"
        tariffZoneLabel.text = receivedData.tariffZone.typeOfTariffZone.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.receivedDataDateLabel.linesCornerRadius = 5
        self.valueLabel.linesCornerRadius = 5
        self.tariffZoneLabel.linesCornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
