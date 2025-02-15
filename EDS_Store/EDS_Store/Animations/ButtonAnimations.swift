//
//  ButtonAnimations.swift
//  EDS_Store
//
//  Created by Илья Морозов on 15.02.2025.
//

import UIKit

class ButtonAnimations {
    static func growSize(layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.1
        animation.duration = 0.3
        animation.autoreverses = true
        
        layer.add(animation, forKey: "growSize")
    }
}

