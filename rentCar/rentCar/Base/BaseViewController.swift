//
//  BaseViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/10.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import Toaster
import SnapKit

class BaseViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var animator = LVAnimator()

    var header: Header?
    var footer: Footer?
    var viewProgress: ProgressView?
    
    // 存在输入框时才设置视图跟随键盘上移
    var isEditExisted = false
    // 只有输入框在下半屏的时候，需要上移
    var isNeedFix = true
    // 如果已经上移了视图，切换输入框即时不在屏幕下半部，也需要下移复位视图
    private var rootOffsetY: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animator.registerDelegate(vc: self)
    }
    
    // MARK:- 转场动画
    func setupAnimator() {
        weak var weakSelf = self
        
        animator.setup(panGestureVC: self, transitionAction: {
                weakSelf?.clickBack()
        }) { (fromVC, toVC, operation) -> Dictionary<String, Any>? in
            switch operation {
            case .push:
                return ["duration" : "0.3", "delegate" : BottomInTransition()]
            case .pop:
                return ["duration" : "0.3", "delegate" : BottomOutTransition()]
            default: break
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏系统导航栏
        self.navigationController?.navigationBar.isHidden = true
        // 背景白色
        self.view.backgroundColor = .WHITE
        
        // 设置转场动画
        setupAnimator()
        
        // 键盘影响视图
        if isEditExisted {
            NotificationCenter.default.addObserver(self, selector: #selector(self.kbFrameChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
    }
    
    // MARK:- 添加Header
    func addHeader() {
        header = Header()
        self.view.addSubview(header!)
        header!.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(60)
            mk.top.equalToSuperview().offset(22)
        }
        header!.vBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickBack)))
    }
    
    /// 点击返回按钮
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 添加Footer
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
        self.navigationController?.pushViewController(CarListViewController(), animated: true)
    }
    
    /// 点击“我的”
    @objc func clickMine() {
        self.navigationController?.pushViewController(MineViewController(), animated: false)
    }
    
    // MARK:- 通用方法
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
    
    //MARK:- 输入框与键盘
    /// 关闭键盘
    @objc func hideKeyboard() {
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
    
    @objc func kbFrameChanged(_ notification: Notification) {
        if isNeedFix || rootOffsetY < 0 {
            // rootOffsetY < 0时，root视图已经上移，则需要下移复位
            let info = notification.userInfo
            let kbRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let offsetY = kbRect.origin.y - screenHeight
            UIView.animate(withDuration: 0.3) {
                self.rootOffsetY = offsetY
                self.view.transform = CGAffineTransform(translationX: 0, y: offsetY)
                self.header?.transform = CGAffineTransform(translationX: 0, y: -offsetY)
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        isNeedFix = textView.isInBottomSideOfScreen()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isNeedFix = textField.isInBottomSideOfScreen()
        return true
    }
    
    // MARK:- 分享
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
    
    // MARK:- 测试数据
    func getTestCar(_ count: Int) -> [CarInfo] {
        let imgList = ["https://pic.wenwen.soso.com/p/20151226/20151226114328-1471319236.jpg",
                       "https://pic.wenwen.soso.com/p/20151226/20151226114326-558979764.jpg",
                       "https://pic.wenwen.soso.com/p/20151226/20151226114328-903976311.jpg",
                       "https://pic.wenwen.soso.com/p/20151226/20151226114329-723161299.jpg",
                       "https://pic.wenwen.soso.com/p/20151226/20151226114549-682156056.jpg"]
        
        var carList: [CarInfo] = []
        for i in 0...count {
            let car = CarInfo()
            var il: [String] = []
            for j in 0...i {
                il.append(imgList[j % imgList.count])
            }
            
            car.name = "新型新型新型新新型新能源车\(i)"
            car.brand = "恒大\(i)"
            car.imgList = il
            car.price = "¥\((i + 1) * 1000)"
            car.sub = "优惠优惠优惠优惠优惠优惠信息\(i)"
            
            carList.append(car)
        }
        
        return carList
    }
    
    // MARK:- Loading视图
    func initProgressView(closure: (ConstraintMaker) -> Void) {
        viewProgress = ProgressView()
        self.view.addSubview(viewProgress!)
        viewProgress?.isHidden = true
        
        viewProgress?.snp.makeConstraints(closure)
    }
    
    func showPb(_ msg: String = "加载中") {
        viewProgress?.isHidden = false
        viewProgress?.lbLoading.text = msg
    }
    
    func hidePb() {
        viewProgress?.isHidden = true
    }
    
    //MARK:- 照片选择框
    func showPhotoPicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let actionSheet = UIAlertController(title: "更换头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // 照相机是否可用
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = delegate
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            } else {
                self.showToast(msg: "无法访问照相机")
            }
        }
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = delegate
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
