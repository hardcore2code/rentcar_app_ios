//
//  ViewProgress.swift
//  rentCar
//
//  Created by Static on 2019/1/15.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var lbLoading: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        
        let bgView = UIView().border(color: .clear)
        bgView.isUserInteractionEnabled = true
        bgView.backgroundColor = .BLACK_TRANS
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (mk) in
            mk.centerX.centerY.equalToSuperview()
            mk.width.height.equalTo(90)
        }
        
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.startAnimating()
        bgView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (mk) in
            mk.centerX.equalToSuperview()
            mk.centerY.equalToSuperview().offset(-10)
            mk.width.height.equalTo(60)
        }
        
        lbLoading = labelLines(14, .WHITE, .center)
        lbLoading.text = "加载中"
        bgView.addSubview(lbLoading)
        lbLoading.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(4)
            mk.right.equalToSuperview().offset(-4)
            mk.height.equalTo(15)
            mk.bottom.equalToSuperview().offset(-8)
        }
    }

}
