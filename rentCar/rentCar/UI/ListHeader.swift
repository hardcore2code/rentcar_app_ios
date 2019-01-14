//
//  ListHeader.swift
//  rentCar
//
//  Created by Static on 2019/1/14.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class ListHeader: UIView {
    
    var btnDo: UILabel!
    var vSection: UIView!
    
    private var vHeight: CGFloat!
    private var hTip: CGFloat!
    private var top: CGFloat!
    private var bottom: CGFloat!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        let vTip = UIView()
        vTip.layer.backgroundColor = UIColor.GREEN_LIGHT_BG.cgColor
        vTip.layer.borderColor = UIColor.GREEN_LIGHT.cgColor
        vTip.layer.borderWidth = 1
        self.addSubview(vTip)
        
        let radius : CGFloat = 32
        let lbImg = label(18, .GRAY, .center)
        lbImg.text = "提醒"
        lbImg.layer.cornerRadius = radius
        lbImg.layer.backgroundColor = UIColor.WHITE.cgColor
        vTip.addSubview(lbImg)
        
        lbImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(radius * 2)
        }
        
        let wText = screenWidth - radius * 2 - horizontalMargin * 2 - padding * 3
        
        let lbTip1 = labelLines(18, .BLACK, .left)
        lbTip1.text = "现只对天津地区的用户服务"
        let h1 = getLabelHeight(lbTip1, wText)
        vTip.addSubview(lbTip1)
        lbTip1.snp.makeConstraints { (make) in
            make.left.equalTo(lbImg.snp.right).offset(padding)
            make.top.equalToSuperview().offset(padding)
            make.height.equalTo(h1)
            make.width.equalTo(wText)
        }
        
        let lbTip2 = labelLines(15, .GRAY, .left)
        lbTip2.text = "请用户下单时一定注意地区问题，如类似问题造成损失，由用户负责"
        let h2 = getLabelHeight(lbTip2, wText)
        vTip.addSubview(lbTip2)
        lbTip2.snp.makeConstraints { (make) in
            make.left.equalTo(lbTip1.snp.left)
            make.top.equalTo(lbTip1.snp.bottom).offset(padding)
            make.height.equalTo(h2)
            make.width.equalTo(wText)
        }
        
        top = 48
        hTip = h1 + h2 + padding * 3
        vTip.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(hTip)
            make.top.equalToSuperview().offset(top)
        }
        
        btnDo = label(24, .WHITE, .center).toButton(.YELLOW)
        btnDo.text = "马上下单"
        self.addSubview(btnDo)
        btnDo.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(vTip.snp.bottom).offset(horizontalMargin)
            mk.height.equalTo(48)
        }
        
        vSection = UIView()
        self.addSubview(vSection)
        
        let l1 = line()
        vSection.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.centerY.equalToSuperview()
            mk.height.equalTo(1)
        }
        
        let lbSection = label(14, .GRAY, .center)
        lbSection.backgroundColor = .WHITE
        lbSection.text = "推荐车型"
        vSection.addSubview(lbSection)
        lbSection.snp.makeConstraints { (mk) in
            mk.top.height.equalToSuperview()
            mk.centerX.equalToSuperview()
            mk.width.equalTo(getLabelWidth(lbSection, 20) + 30)
        }
    
        vSection.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(vTip.snp.bottom).offset(48 + horizontalMargin * 2)
            mk.height.equalTo(20)
        }
        
        bottom = horizontalMargin
    }
    
    func getHeight() -> CGFloat {
        return top + hTip + 2 + (btnDo.isHidden ? 0 : (48 + horizontalMargin)) + (vSection.isHidden ? 0 : (20 + horizontalMargin)) + bottom
    }

}
