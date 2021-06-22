//
//  GradientView.swift
//  mpges.lk
//
//  Created by Timur on 04.04.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }
    
    private func updateColors() {
        self.gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
