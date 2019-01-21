//
//  UIScrollView.swift
//  rentCar
//
//  Created by Static on 2019/1/16.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    /// 纵向ScrollView
    func normalVertical() -> UIScrollView {
        self.isUserInteractionEnabled = true
        self.alwaysBounceVertical = true
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        return self
    }
}
