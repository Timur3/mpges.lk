//
//  DevileryOfInvoiceTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class DeliveryOfInvoiceTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    
    static let identifier = "deliveryOfInvoiceCell"
    
    func update(for text: String) {
        self.txtLabel.text = text
        self.imgView.image = UIImage(systemName: myImage.mail.rawValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.txtLabel.linesCornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
