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

    func update(for receivedData: ReceivedDataModel) {
        receivedDataDateLabel.text = receivedData.date
        valueLabel.text = "\(receivedData.value) кВт/час"
        tariffZoneLabel.text = receivedData.tariffZone
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
