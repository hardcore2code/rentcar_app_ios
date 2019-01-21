//
//  String.swift
//  rentCar
//
//  Created by Static on 2019/1/18.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation

extension String {
    
    /// 隐藏手机号中间四位
    func toPhone() -> String {
        if self.count < 11 {
            return self
        } else {
            return "\(self.prefix(3))****\(self.suffix(4))"
        }
    }
}
