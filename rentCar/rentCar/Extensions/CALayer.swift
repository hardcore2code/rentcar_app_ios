//
//  CALayer.swift
//  EasyStuff
//
//  Created by Static on 03/03/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    
    func setBorderUIColor(_ color: UIColor) {
        self.borderColor = color.cgColor
    }
    
    func borderUIColor() -> UIColor {
        return UIColor.init(cgColor: self.borderColor!)
    }
}
