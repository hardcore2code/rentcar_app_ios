//
//  UserDefaultKeys.swift
//  EasyStuff
//
//  Created by Static on 14/02/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let KEY_TABLEVIEW_MODE_GRID: String = "KEY_TABLEVIEW_MODE_GRID"
    static let KEY_PROPORTION_DATA: String = "KEY_PROPORTION_DATA"
    
    // 列表显示方式是否为网格
    static func isTableViewModeGrid() -> Bool {
        return UserDefaults.standard.bool(forKey: KEY_TABLEVIEW_MODE_GRID)
    }
    
    // 设置列表显示方式
    static func setTableViewMode(isGrid: Bool) {
        UserDefaults.standard.set(isGrid, forKey: KEY_TABLEVIEW_MODE_GRID)
    }
    
    /*
     保存比例换算数值
    */
    static func saveProportionData(_ data: [Double]) {
        UserDefaults.standard.set(data, forKey: KEY_PROPORTION_DATA)
    }
    
    /*
     获取上一次比例换算数值
     */
    static func getProportionData() -> [Double]? {
        return UserDefaults.standard.array(forKey: KEY_PROPORTION_DATA) as? [Double]
    }
}
