//
//  DevileryOfInvoiceTableViewCell.swift
//  mpges.lk
//
//  Created by Timur on 24.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

enum deliveryType: Int {
    case address = 1
    case email = 2
    case lk = 3
    case office = 4
}

class InvoiceDeliveryMethodsTableViewCell: UITableViewCell {
    
    func update(_ model: InvoiceDeliveryMethodModel) {
        textLabel?.text = model.devileryMethodName
        detailTextLabel?.text = model.description        
        imageView?.image = UIImage(systemName: getImage(model.id))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
