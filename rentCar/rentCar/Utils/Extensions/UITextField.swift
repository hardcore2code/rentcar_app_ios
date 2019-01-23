//
//  UITextField.swift
//  rentCar
//
//  Created by Static on 2019/1/22.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation

extension UITextField {
    
    func setPlaceholder(_ phColor: UIColor, _ fontSize: CGFloat = 0) -> UITextField {
        if fontSize != 0 {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
        }
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: phColor])
        return self
    }
}
