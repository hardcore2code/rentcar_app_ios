//
//  Dimens.swift
//  EasyStuff
//
//  Created by Static on 2018/4/24.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let horizontalMargin: CGFloat = 24
let padding : CGFloat = 8

/// 获取系统字体
///
/// - Parameter size: 字体大小
/// - Returns: UIFont
func font(_ size: Int) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(size))
}

/// 通用输入框
///
/// - Parameters:
///   - fontSize: 字体大小
///   - textColor: 字体颜色
///   - placeholder: 提示文字
func tField(_ fontSize: Int = 14, _ textColor: UIColor = .BLACK, _ placeholder: String = "请输入") -> UITextField {
    let tf = UITextField()
    tf.font = font(fontSize)
    tf.textColor = textColor
    tf.placeholder = placeholder
    return tf
}

/// 通用输入框
///
/// - Parameter placeholder: 提示文字
func tField(_ placeholder: String) -> UITextField {
    return tField(14, .BLACK, placeholder)
}

/// 获取UILabel
///
/// - Parameters:
///   - fontSize: 字体大小
///   - textColor: 字体颜色
///   - textAlign: 文字布局
/// - Returns: UILabel
func label(_ fontSize: Int = 15, _ textColor: UIColor = UIColor.GRAY, _ textAlign: NSTextAlignment = NSTextAlignment.left) -> UILabel {
    let label = UILabel()
    label.font = font(fontSize)
    label.textColor = textColor
    label.textAlignment = textAlign
    return label
}

/// 获取可计算高度的UILabel
///
/// - Parameters:
///   - fontSize: 字体大小
///   - textColor: 字体颜色
///   - textAlign: 文字布局
/// - Returns: UILabel
func labelLines(_ fontSize: Int = 15, _ textColor: UIColor = UIColor.GRAY, _ textAlign: NSTextAlignment = NSTextAlignment.left) -> UILabel {
    let mLabel = label(fontSize, textColor, textAlign)
    mLabel.lineBreakMode = .byCharWrapping
    mLabel.numberOfLines = 0
    return mLabel
}

func labelCenter() -> UILabel {
    return label(15, UIColor.GRAY, .center)
}


/// 分割线
///
/// - Returns: 分割线
func line() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.GRAY_LINE
    return view
}

func line(_ color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
}

/// 获取文字宽度
func getStrWidth(labelStr: String, font: UIFont, height: CGFloat) -> CGFloat {
    let string: NSString = labelStr as NSString
    let size = CGSize(width: 1000, height: height)
    let strSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    
    return strSize.width
}

func getLabelWidth(_ label: UILabel, _ height: CGFloat) -> CGFloat {
    return getStrWidth(labelStr: label.text!, font: label.font, height: height)
}

/// 获取label的高度
/// Label的lineBreakMode = .byCharWrapping
/// numberOfLines = 0
///
/// - Parameters:
///   - labelStr: label文字
///   - font: label字体
///   - width: label宽度（宽度必须提前设置）
/// - Returns: 高度
func getStrHeight(labelStr: String, font: UIFont, width: CGFloat) -> CGFloat {
    let string: NSString = labelStr as NSString
    let size = CGSize(width: width, height: 1000)
    let strSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    
    NSLog.i("getStrHeight = \(strSize.height)")
    return strSize.height
}

func getLabelHeight(_ label: UILabel, _ width: CGFloat) -> CGFloat {
    return getStrHeight(labelStr: label.text!, font: label.font, width: width)
}

/// 获取Label宽度
func getLabelWidth(label: UILabel) -> CGFloat {
    return getStrWidth(labelStr: label.text!, font: label.font, height: label.frame.height)
}

/// 360度无限旋转视图
///
/// - Parameters:
///   - view: 旋转视图
///   - duration: 旋转一圈需要的时间
func rotate360Repeat(view: UIView, duration: TimeInterval) {
    UIView.animate(withDuration: duration / 2, delay: 0.01, options: .curveLinear, animations: {
        view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }) { (_) in
        UIView.animate(withDuration: duration / 2, delay: 0, options: .curveLinear, animations: {
            view.transform = CGAffineTransform(rotationAngle: CGFloat(2 * Double.pi))
        }, completion: { (_) in
            rotate360Repeat(view: view, duration: duration)
        })
    }
}
