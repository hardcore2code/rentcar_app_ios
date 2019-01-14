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
    
    /// 设置阴影（模拟CardView）
    ///
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影半径
    ///   - offset: 阴影偏移量
    /// - Returns: 阴影
    func shadow(_ color: UIColor = .GRAY_LINE, _ opacity: Float = 0.8, _ radius: CGFloat = 2, _ offset: CGSize = CGSize.init(width: 2, height: 2)) -> UIView {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        
        return self
    }
}
