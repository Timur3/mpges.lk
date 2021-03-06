//
//  DeviceTVCell.swift
//  mpges.lk
//
//  Created by Timur on 20.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ReceivedDataAddNewDelegate {
    func onClick(index: Int)
}

class DeviceTVCell: UITableViewCell {

    @IBOutlet weak var deviceNumber: UILabel!
    @IBOutlet weak var modelNameDevice: UILabel!
    @IBOutlet weak var addressSetDevice: UILabel!
    @IBOutlet var deviceDateOut: UILabel!
    @IBOutlet var deviceDateCalibration: UILabel!
    @IBOutlet var deviceDateNextCalibration: UILabel!
    @IBOutlet var receivedDataAddNewButton: UIButton!
    
    static let identifier = "deviceCell"
    
    var delegateCell: ReceivedDataAddNewDelegate?
    var index: IndexPath?
    
    @IBAction func ReceivedDataAddNewAction(_ sender: Any) {
        delegateCell?.onClick(index: index!.section)
    }
    
    func update(for device: DeviceModel) {
        deviceNumber.text = device.deviceNumber
        deviceDateOut.text = device.dateOut
        deviceDateCalibration.text = device.dateStateCalibration
        deviceDateNextCalibration.text = device.dateNextCalibration
        modelNameDevice.text = device.modelsOfDevice.typeName
        addressSetDevice.text = device.addressSet
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // for skeletonView
        self.imageView?.isSkeletonable = true
        deviceNumber.lastLineFillPercent = 50
        deviceNumber.linesCornerRadius = 5
        modelNameDevice.lastLineFillPercent = 50
        modelNameDevice.linesCornerRadius = 5
        addressSetDevice.lastLineFillPercent = 50
        addressSetDevice.linesCornerRadius = 5
        deviceDateOut.lastLineFillPercent = 50
        deviceDateOut.linesCornerRadius = 5
        deviceDateCalibration.lastLineFillPercent = 50
        deviceDateCalibration.linesCornerRadius = 5
        deviceDateNextCalibration.lastLineFillPercent = 50
        deviceDateNextCalibration.linesCornerRadius = 5
        
        receivedDataAddNewButton.layer.cornerRadius = 8.0
        receivedDataAddNewButton.layer.borderWidth = 1.0
        receivedDataAddNewButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
