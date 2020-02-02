//
//  ReceivedDataTVCell.swift
//  mpges.lk
//
//  Created by Timur on 23.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataTVCell: UITableViewCell {
    
    @IBOutlet weak var tariffZoneName: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var receivedDataType: UILabel!
    
    var receivedData: ReceivedDataModel? {
        didSet {
            tariffZoneName.text = receivedData?.tariffZone
            valueLabel.text = "\(String(describing: receivedData?.value)) кВт/час"
            receivedDataType.text = receivedData?.typeOfReceivedData
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
