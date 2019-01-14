//
//  UILabel.swift
//  rentCar
//
//  Created by Static on 2019/1/14.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    /// 按钮效果
    ///
    /// - Parameter color: 背景色
    /// - Returns: 按钮
    func toButton(_ color: UIColor) -> UILabel {
        self.layer.backgroundColor = color.cgColor
        self.layer.cornerRadius = 8
        self.isUserInteractionEnabled = true
        
        return self
    }
    
    func toCorner(_ bgColor: UIColor, _ radius: CGFloat = 4) -> UILabel {
        self.layer.backgroundColor = bgColor.cgColor
        self.layer.cornerRadius = radius
        
        return self
    }
}
