//
//  UIColor.swift
//  EasyStuff
//
//  Created by Static on 12/02/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     *  主色      副色
     红：#FF0000  #FFF0F5 浅红(收藏) #FF0056
     橙：#FFA500  #FFDEAD
     黄：#FFFF00  #FFFFE0
     绿：#008000  #98FB98
     青：#00FFFF  #E1FFFF
     蓝：#489CFA  #F0F8FF
     紫：#800080  #FFCCFF
     灰：背景#F9F9F9 线#C9C9C9
     */
    
    // 红
    static let RED          = withHex(hexString: "#FF0000")
    static let RED_LIGHT    = withHex(hexString: "#FFF0F5")
    static let RED_LIGHT2   = withHex(hexString: "#FF0056")
    
    // 橙
    static let ORANGE       = withHex(hexString: "#FFA500")
    static let ORANGE_LIGHT = withHex(hexString: "#FFDEAD")
    
    // 黄
    static let YELLOW       = withHex(hexString: "#FFC04C")
    static let YELLOW_LIGHT = withHex(hexString: "#FFFFE0")
    
    // 绿
    static let GREEN        = withHex(hexString: "#008000")
    static let GREEN_LIGHT  = withHex(hexString: "#98FB98")
    
    // 青
    static let CYAN         = withHex(hexString: "#00FFFF")
    static let CYAN_LIGHT   = withHex(hexString: "#E1FFFF")
    
    // 蓝
    static let BLUE         = withHex(hexString: "#489CFA")
    static let BLUE_LIGHT   = withHex(hexString: "#F0F8FF")
    
    // 紫
    static let PURPLE       = withHex(hexString: "#800080")
    static let PURPLE_LIGHT = withHex(hexString: "#FFCCFF")
    
    // 黑、白、灰
    static let BLACK        = withHex(hexString: "#000000")
    static let BLACK_TRANS  = withHex(hexString: "#000000", alpha: 0.4)
    static let WHITE        = withHex(hexString: "#FFFFFF")
    static let GRAY         = gray
    static let GRAY_BG      = withHex(hexString: "#F9F9F9")
    static let GRAY_TRANS   = withHex(hexString: "#F9F9F9", alpha: 0.4)
    static let GRAY_LINE    = withHex(hexString: "#C9C9C9")
    
    // 透明色
    static let TRANS        = UIColor.clear
    
    /**
     获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000
     - parameter hexString  : 16进制字符串
     - parameter alpha      : 透明度，默认为1，不透明
     - returns: RGB
     */
    static func withHex(hexString hex: String, alpha:CGFloat = 1) -> UIColor {
        // 去除空格等
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.count != 6) {
            return UIColor.GRAY
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /**
     获取颜色，通过16进制数值
     - parameter hexInt : 16进制数值
     - parameter alpha  : 透明度
     - returns : 颜色
     */
    static func withHex(hexInt hex:Int32, alpha:CGFloat = 1) -> UIColor {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0xff00) >> 8) / 255
        let b = CGFloat(hex & 0xff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /**
     获取颜色，通过rgb
     - parameter red    : 红色
     - parameter green  : 绿色
     - parameter blue   : 蓝色
     - returns : 颜色
     */
    static func withRGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> UIColor {
        return UIColor.withRGBA(red, green, blue, 1)
    }
    
    /**
     获取颜色，通过rgb
     - parameter red    : 红色
     - parameter green  : 绿色
     - parameter blue   : 蓝色
     - parameter alpha  : 透明度
     - returns : 颜色
     */
    static func withRGBA(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    /**
     获取随机颜色
     */
    static func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// rgb转html
    static func toHtml(red: CGFloat, green: CGFloat, blue: CGFloat) -> String {
        return String(format: "#%02x%02x%02x", Int(red), Int(green), Int(blue))
    }
    
    /// rgb转html
    static func toHtml(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> String {
        return String(format: "#%02x%02x%02x%02x",Int(alpha * 255), Int(red), Int(green), Int(blue))
    }
}
