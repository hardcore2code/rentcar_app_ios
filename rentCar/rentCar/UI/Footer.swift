//
//  Footer.swift
//  rentCar
//
//  Created by Static on 2019/1/10.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import SnapKit

class Footer: UIView {
    
    var lbHome: UILabel!
    var lbMine: UILabel!
    var ivAdd: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        let tline = line()
        self.addSubview(tline)
        tline.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        lbHome = label(22, .BLACK, .center)
        lbHome.isUserInteractionEnabled = true
        lbHome.text = "首页"
        self.addSubview(lbHome)
        lbHome.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.left.top.equalToSuperview()
        }
        
        lbMine = label(22, .GRAY, .center)
        lbMine.isUserInteractionEnabled = true
        lbMine.text = "我的"
        self.addSubview(lbMine)
        lbMine.snp.makeConstraints { (make) in
            make.right.height.top.equalToSuperview()
            make.width.equalTo(lbHome.snp.width)
        }
        
        ivAdd = UIImageView(image: UIImage(named: "add"))
        ivAdd.isUserInteractionEnabled = true
        ivAdd.contentMode = .center
        ivAdd.layer.cornerRadius = 8
        ivAdd.layer.backgroundColor = UIColor.YELLOW.cgColor
        self.addSubview(ivAdd)
        ivAdd.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

}
