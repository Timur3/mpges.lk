//
//  TableViewHelper.swift
//  mpges.lk
//
//  Created by Timur on 06.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

public func getEmptyLabelView(header: String, width: CGFloat, height: CGFloat) -> UIView {
    let emptyView = UIView()
    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        noDataLabel.text =  header
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        noDataLabel.addSubview(emptyView)
    return emptyView
}
