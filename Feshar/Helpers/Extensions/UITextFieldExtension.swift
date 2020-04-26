//
//  UITextFieldExtension.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/26/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

extension UITextField {
    func shake(horizantaly:CGFloat = 0  , Verticaly:CGFloat = 0) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - horizantaly, y: self.center.y - Verticaly ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + horizantaly, y: self.center.y + Verticaly ))
        
        
        self.layer.add(animation, forKey: "position")
        
    }
}
