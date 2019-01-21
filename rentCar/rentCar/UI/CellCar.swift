//
//  CellCar.swift
//  rentCar
//
//  Created by Static on 2019/1/14.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class CellCar: UITableViewCell, FSPagerViewDelegate, FSPagerViewDataSource {
    private let vpId = "img_id"
    var car: CarInfo!
    var iHeight: CGFloat!
    
    var lbType: UILabel!
    var vpImg: FSPagerView!
    private var vpControl: FSPageControl!
    var lbBrand: UILabel!
    var lbName: UILabel!
    var lbPrice: UILabel!
    var lbSub: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .WHITE
        let imgWidth = screenWidth - horizontalMargin * 2 - 2
        let imgHeight = imgWidth * IMG_HEIGHT / IMG_WIDTH
        
        iHeight = imgHeight + 80 + 40.5
        
        let card = UIView().shadow()
        card.backgroundColor = .WHITE
        card.toBorder(4)
        self.addSubview(card)
        card.snp.makeConstraints { (mk) in
            mk.left.top.equalToSuperview()
            mk.right.equalToSuperview().offset(-2)
            mk.height.equalTo(iHeight)
        }
        
        let v = UIView().corner(4)
        v.clipsToBounds = true
        card.addSubview(v)
        v.snp.makeConstraints { (mk) in
            mk.left.right.top.equalToSuperview()
            mk.height.equalTo(imgHeight)
        }
        
        vpImg = FSPagerView()
        vpImg.delegate = self
        vpImg.dataSource = self
        vpImg.register(FSPagerViewCell.self, forCellWithReuseIdentifier: vpId)
        vpImg.isInfinite = true
        vpImg.transformer = FSPagerViewTransformer(type: .linear)
//        vpImg.automaticSlidingInterval = 4
        v.addSubview(vpImg)
        vpImg.snp.makeConstraints { (mk) in
            mk.left.right.top.bottom.equalToSuperview()
        }
        
        vpControl = FSPageControl()
        vpControl.numberOfPages = car == nil ? 0 : car.imgList.count
        vpControl.currentPage = 0
        vpControl.setFillColor(.YELLOW, for: .selected)
        vpControl.setFillColor(.TRANS, for: .normal)
        vpControl.setStrokeColor(.WHITE, for: .normal)
        v.addSubview(vpControl)
        vpControl.snp.makeConstraints { (mk) in
            mk.left.right.bottom.equalTo(vpImg)
            mk.height.equalTo(20)
        }
        
        lbType = label(13, .WHITE, .center).toCorner(.GREEN_LIGHT)
        lbType.text = "新能源"
        card.addSubview(lbType)
        lbType.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(16)
            mk.top.equalToSuperview().offset(12)
            mk.height.equalTo(24)
            mk.width.equalTo(getLabelWidth(lbType, 24) + 16)
        }
        
        lbBrand = label(16, .brown, .left)
        lbBrand.text = "品牌名称"
        card.addSubview(lbBrand)
        lbBrand.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(padding * 2)
            mk.right.equalToSuperview().offset(-padding * 2)
            mk.top.equalTo(vpImg.snp.bottom).offset(8)
            mk.height.equalTo(32)
        }
        
        lbName = label(18, .BLACK, .left)
        lbName.text = "车型名称"
        card.addSubview(lbName)
        lbName.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbBrand)
            mk.top.equalTo(lbBrand.snp.bottom)
            mk.height.equalTo(32)
        }
        
        let l1 = line()
        card.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(lbName.snp.bottom).offset(8)
            mk.height.equalTo(0.5)
        }
        
        lbPrice = label(16, .BLACK, .left)
        lbPrice.text = "¥8000"
        card.addSubview(lbPrice)
        lbPrice.snp.makeConstraints { (mk) in
            mk.left.equalTo(lbBrand)
            mk.top.equalTo(l1.snp.bottom)
            mk.height.equalTo(40)
            mk.width.equalTo(getLabelWidth(lbPrice, 36) + 12)
        }
        
        lbSub = label(16, .GRAY, .left)
        lbSub.text = "优惠信息"
        card.addSubview(lbSub)
        lbSub.snp.makeConstraints { (mk) in
            mk.height.top.equalTo(lbPrice)
            mk.left.equalTo(lbPrice.snp.right)
            mk.right.equalTo(lbBrand)
        }
    }
    
    func reloadPager() {
        vpImg.reloadData()
        vpControl.numberOfPages = car.imgList.count
        
        lbBrand.text = car.brand
        lbName.text = car.name
        lbPrice.text = car.price
        lbSub.text = car.sub
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return car.imgList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: vpId, at: index)
        cell.imageView?.kf.setImage(with: URL(string: car.imgList[index]), placeholder: UIImage.init(color: UIColor.GRAY_BG), options: nil, progressBlock: nil, completionHandler: nil)
        
        vpControl.currentPage = index
        return cell
    }
    
    
}
