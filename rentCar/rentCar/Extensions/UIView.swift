//
//  UILabel.swift
//  EasyStuff
//
//  Created by Static on 2018/5/14.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func border(_ radius: CGFloat = 8, _ color: UIColor = .GRAY_LINE, _ width: CGFloat = 0.5) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        return self
    }
    
    func border(color: UIColor = .GRAY_LINE) -> UIView {
        return border(8, color, 0.5)
    }
    
    func toBorder(_ radius: CGFloat = 8, _ color: UIColor = .GRAY_LINE, _ width: CGFloat = 0.5) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
