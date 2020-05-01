//
//  DeviceTVCell.swift
//  mpges.lk
//
//  Created by Timur on 20.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class DeviceTVCell: UITableViewCell {

    @IBOutlet weak var deviceNumber: UILabel!
    @IBOutlet weak var modelNameDevice: UILabel!
    @IBOutlet weak var addressSetDevice: UILabel!
    @IBOutlet var deviceDateOut: UILabel!
    @IBOutlet var deviceDateCalibration: UILabel!
    @IBOutlet var deviceDateNextCalibration: UILabel!
    
    func update(for device: DeviceModel) {
        deviceNumber.text = device.deviceNumber
        deviceDateOut.text = device.dateOut
        deviceDateCalibration.text = device.dateStateCalibration
        deviceDateNextCalibration.text = device.dateNextCalibration
        modelNameDevice.text = device.deviceTypeName
        addressSetDevice.text = device.addressSet
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
