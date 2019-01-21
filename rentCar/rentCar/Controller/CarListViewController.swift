//
//  CarListViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/15.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class CarListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let reuseId = "car_id"
    
    private var lv: UITableView!
    
    private var itemHeight: CGFloat!
    private var carList: [CarInfo] = []
    
    let mjHeader = MJRefreshNormalHeader()
    let mjFooter = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        requestData()
    }
    
    func initView() {
        itemHeight = (screenWidth - horizontalMargin * 2 - 2) * IMG_HEIGHT / IMG_WIDTH + 120.5
        
        lv = UITableView()
        lv.delegate = self
        lv.dataSource = self
        lv.showsVerticalScrollIndicator = false
        lv.separatorStyle = .none
        lv.register(CellCar.self, forCellReuseIdentifier: reuseId)
        
        let lvHeader = ListHeader()
        lvHeader.btnDo.isHidden = true
        lvHeader.vSection.isHidden = true
        lvHeader.frame = CGRect.init(x: 0, y: 0, width: screenWidth - horizontalMargin * 2, height: lvHeader.getHeight())
        lv.tableHeaderView = lvHeader
        
        mjHeader.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        lv.mj_header = mjHeader
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        lv.mj_footer = mjFooter
        
        self.view.addSubview(lv)
        
        lv.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalToSuperview().offset(22)
            mk.bottom.equalToSuperview()
        }
        
        initProgressView { (mk) in
            mk.left.right.top.bottom.equalTo(lv)
        }
    }
    
    //MARK:- 请求数据
    @objc func headerRefresh() {
        requestData(true)
    }
    
    @objc func footerRefresh() {
        requestData(true)
    }
    
    private func requestData(_ isRefresh: Bool = false) {
        if !isRefresh {
            showPb()
        }
        
        RentCarProvider.request(.call("Pro_WL_MoblieLoad", ["CompanyId": "10001", "InUser": "admin", "inPwd": "123"])) { result in
            switch result {
            case let .success(response):
                let data = try? response.mapString()
                NSLog.i(data!)
                self.updateList()
                break
            case let .failure(error):
                NSLog.e(error)
                break
            }
            // 恢复视图
            if !isRefresh {
                self.hidePb()
            } else {
                self.mjHeader.endRefreshing()
                self.mjFooter.endRefreshingWithNoMoreData()
            }
        }
    }
    
    //MARK:- 加载数据
    private func updateList() {
        carList = getTestCar(8)
        lv.reloadData()
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight + horizontalMargin
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! CellCar
        cell.car = carList[indexPath.row]
        cell.reloadPager()
        return cell
    }
}
