//
//  MineViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/11.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import Kingfisher

class MineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        addFooter()
        noSideGes()
        
        let iv = UIImageView()
        self.view.addSubview(iv)
        iv.snp.makeConstraints { (mk) in
            mk.left.top.equalToSuperview().offset(22)
            mk.width.height.equalTo(80)
        }
        iv.kf.setImage(with: URL(string: "http://img5.duitang.com/uploads/item/201411/07/20141107164412_v284V.jpeg"), placeholder: UIImage(color: UIColor.red), options: nil, progressBlock: nil, completionHandler: nil)
    }

}
