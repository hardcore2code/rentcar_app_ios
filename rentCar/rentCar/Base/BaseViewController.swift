//
//  BaseViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/10.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import Toaster

class BaseViewController: UIViewController {

    var footer: Footer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏系统导航栏
        self.navigationController?.navigationBar.isHidden = true
        // 背景白色
        self.view.backgroundColor = .WHITE
    }
    
    /// 添加Footer
    func addFooter() {
        footer = Footer()
        self.view.addSubview(footer!)
        footer!.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        if self is MineViewController {
            footer!.lbHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickHome)))
            footer!.lbHome.textColor = .GRAY
            footer!.lbMine.textColor = .BLACK
        } else if self is HomeViewController {
            footer!.lbMine.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickMine)))
        }
        footer!.ivAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickAdd)))
    }
    
    /// 点击“首页”
    @objc func clickHome() {
        self.navigationController?.popViewController(animated: false)
    }
    
    /// 点击“添加”
    @objc func clickAdd() {
        showToast(msg: "添加")
    }
    
    /// 点击“我的”
    @objc func clickMine() {
        self.navigationController?.pushViewController(MineViewController(), animated: false)
    }
    
    /// 禁止侧滑返回
    func noSideGes() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    /// Toast统一
    ///
    /// - Parameter msg: 文字
    func showToast(msg: String!) {
        Toast(text: msg).show()
    }
    
    /// 点击返回按钮
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 关闭键盘
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    /// 点击空白区域关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        hideKeyboard()
    }
    
    /// 滚动UIScrollView时关闭键盘
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    /// 调起系统分享
    /// 部分渠道图片和文字不能同时分享
    /// - Parameters:
    ///   - str: 文字
    ///   - img: 图片
    ///   - url: URL地址
    func shareBySystem(str: String!, img: UIImage?, url: String?, handler: ((UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Swift.Void)?) {
        var arr: [Any] = []
        arr.append(str)
        if img != nil {
            arr.append(img!)
        }
        if url != nil {
            arr.append(NSURL.init(string: url!) as Any)
        }
        
        let ac = UIActivityViewController(activityItems: arr, applicationActivities: nil)
        // 不出现在活动中的项目
        // ac.excludedActivityTypes = [.print, .assignToContact, .saveToCameraRoll]
        if handler != nil {
            ac.completionWithItemsHandler = handler
        }
        present(ac, animated: true, completion: nil)
    }
    
    /// 复制到剪贴板
    ///
    /// - Parameter str: 复制文字
    func pasteStr(_ str: String, selector: Selector) {
        UIPasteboard.general.string = str
        showToast(msg: "已复制到剪贴板:\(str)")
    }
}
