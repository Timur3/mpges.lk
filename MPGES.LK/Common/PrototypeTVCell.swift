//
//  PrototypeTVCell.swift
//  mpges.lk
//
//  Created by Timur on 17.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class PrototypeTVCell: UITableViewCell {
    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
