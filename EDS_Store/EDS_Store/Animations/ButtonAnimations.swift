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
    
    static let shared = ButtonAnimations()
    
    @objc func littleAndAlpha(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.7
            sender.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }
    }
    
    @objc func comeback(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 1
            sender.transform = CGAffineTransform.identity
        }
    }
}

