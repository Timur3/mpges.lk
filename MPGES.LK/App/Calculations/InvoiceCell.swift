//
//  InvoiceCell.swift
//  mpges.lk
//
//  Created by Timur on 24.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoiceCellDelegate {
    func accessoryViewTapping(indexPath: IndexPath)
}

class InvoiceCell: UITableViewCell {
    public var delegateCell: InvoiceCellDelegate?
    public var indexPath: IndexPath?
    
    func update(for invoice: InvoiceModel) {
        textLabel!.text = invoice.month?.name
        detailTextLabel?.text = "\(invoice.year)"
        imageView?.image = UIImage(systemName: myImage.textPlus.rawValue)
        
        let imgView = UIImageView(image: UIImage(systemName: myImage.dote.rawValue))
        imgView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(alertShowInvoiceAction(tapGestureRecognizer:)))
        imgView.addGestureRecognizer(tapGestureRecognizer)
        accessoryView = imgView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func alertShowInvoiceAction(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegateCell?.accessoryViewTapping(indexPath: self.indexPath!)
    }
}
