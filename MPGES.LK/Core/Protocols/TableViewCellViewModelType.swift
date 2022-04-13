//
//  TableViewCellViewModelType.swift
//  mpges.lk
//
//  Created by Timur on 20.06.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCellViewModelType: AnyObject {
    var textLabel: String { get  }
    var detailTextLabel: String { get  }
    var image: UIImage { get }
    var selected: Bool { get }
}
