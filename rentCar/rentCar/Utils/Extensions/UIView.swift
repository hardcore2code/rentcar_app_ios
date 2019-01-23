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
    
    func corner(_ radius: CGFloat = 8) -> UIView {
        self.layer.cornerRadius = radius
        return self
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 圆角位置
    ///   - radii: 圆角半径
    /// - Returns: 部分圆角
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat = 8) -> UIView {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
    
    func corner(rect: CGRect, byRoundingCorners corners: UIRectCorner, radii: CGFloat = 8) -> UIView {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
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
    
    /// 获取相对屏幕的位置
    ///
    /// - Returns: 位置
    func rectToWindow() -> CGRect {
        let win = UIApplication.shared.delegate?.window!
        return self.convert(self.bounds, to: win)
    }
    
    /// 视图是否在屏幕下半部分
    ///
    /// - Returns: 视图是否在屏幕下半部分
    func isInBottomSideOfScreen() -> Bool {
        return rectToWindow().origin.y > screenHeight / 2
    }
    
    /// 添加点击事件
    ///
    /// - Parameters:
    ///   - target: 相应视图
    ///   - selector: 点击事件
    func setOnClickListener(target: Any?, action: Selector?) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
}
