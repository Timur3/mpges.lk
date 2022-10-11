//
//  LabelHelper.swift
//  mpges.lk
//
//  Created by Timur on 04.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

func getCustomForCardLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

func getCustomLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    //label.font = UIFont.boldSystemFont(ofSize: 15)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}
