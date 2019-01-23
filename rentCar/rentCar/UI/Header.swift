//
//  Header.swift
//  rentCar
//
//  Created by Static on 2019/1/18.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class Header: UIView {

    var vBack: UIView!
    var ivBack: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = .WHITE
        
        vBack = UIView()
        self.addSubview(vBack)
        vBack.snp.makeConstraints { (mk) in
            mk.left.top.equalToSuperview()
            mk.width.height.equalTo(60)
        }
        
        ivBack = UIImageView(image: UIImage(named: "arrow_left")?.tint(color: .YELLOW))
        ivBack.contentMode = .scaleAspectFit
        vBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { (mk) in
            mk.center.equalToSuperview()
            mk.width.height.equalTo(36)
        }
    }

}
