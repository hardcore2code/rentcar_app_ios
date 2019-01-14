//
//  ViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/8.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let reuseId = "home_id"

    private var lv: UITableView!
    
    private var itemHeight: CGFloat!
    private var carList: [CarInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        updateList()
    }

    func initView() {
        itemHeight = (screenWidth - horizontalMargin * 2 - 2) * IMG_HEIGHT / IMG_WIDTH + 116.5
        
        addFooter()
        
        let header = ListHeader()
        
        lv = UITableView()
        lv.delegate = self
        lv.dataSource = self
        lv.showsVerticalScrollIndicator = false
        lv.separatorStyle = .none
        lv.register(CellCar.self, forCellReuseIdentifier: reuseId)
        
        header.frame = CGRect.init(x: 0, y: 0, width: screenWidth - horizontalMargin * 2, height: header.getHeight())
        lv.tableHeaderView = header
        self.view.addSubview(lv)
        
        lv.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalToSuperview()
            mk.bottom.equalTo(footer!.snp.top)
        }
    }
    
    private func updateList() {
        carList = getTestCar(4)
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

