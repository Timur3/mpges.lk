//
//  UIImageHelper.swift
//  mpges.lk
//
//  Created by Timur on 25.04.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func imageWithSize(scaledToSize newSize: CGSize) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

}