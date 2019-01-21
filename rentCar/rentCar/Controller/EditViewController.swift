//
//  EditViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/18.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var contentWidth: CGFloat!
    private var contentHeight: CGFloat!
    
    private var lbPhone: UILabel!
    private var ivAvatar: UIImageView!
    private var lbAvatar: UILabel!
    
    private var tfName: UITextField!
    private var tfEmail: UITextField!
    private var tfAddress: UITextView!
    
    private var tfEmName: UITextField!
    private var tfEmPhone: UITextField!
    private var tfIncome: UITextField!
    private var tfInfoFrom: UITextView!
    private var tfUse: UITextView!
    
    private var user: UserInfo!
    private var lastHeights: [CGFloat] = [40, 40, 40]
    private var imgUploadStr: String = ""
    
    override func viewDidLoad() {
        isEditExisted = true
        super.viewDidLoad()

        initView()
        loadData()
    }

    func initView() {
        addHeader()
        
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        contentWidth = screenWidth - horizontalMargin * 2
        
        let btnSubmit = label(24, .WHITE, .center).toButton(.YELLOW)
        btnSubmit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickSubmit)))
        btnSubmit.text = "保存"
        self.view.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.height.equalTo(48)
            mk.bottom.equalToSuperview().offset(-padding)
        }
        
        let lineBottom = line()
        self.view.addSubview(lineBottom)
        lineBottom.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.bottom.equalTo(btnSubmit.snp.top).offset(-padding)
            mk.height.equalTo(0.5)
        }
        
        scrollView = UIScrollView().normalVertical()
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (mk) in
            mk.top.equalTo(header!.snp.bottom)
            mk.bottom.equalTo(lineBottom.snp.top)
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        let lb1 = label(30, .BLACK, .left).text("编辑个人信息")
        contentView.addSubview(lb1)
        lb1.snp.makeConstraints { (mk) in
            mk.left.top.right.equalToSuperview()
            mk.height.equalTo(40)
        }
        
        let avatarView = UIView()
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickAvatar)))
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(lb1.snp.bottom).offset(20)
            mk.height.equalTo(80)
        }
        
        ivAvatar = UIImageView().corner(40) as? UIImageView
        ivAvatar.backgroundColor = .GRAY_BG
        avatarView.addSubview(ivAvatar)
        ivAvatar.snp.makeConstraints { (mk) in
            mk.right.equalToSuperview().offset(-12)
            mk.width.height.equalTo(80)
            mk.centerY.equalToSuperview()
        }
        
        lbAvatar = label(18, .WHITE, .center)
        lbAvatar.text = "头像"
        ivAvatar.addSubview(lbAvatar)
        lbAvatar.snp.makeConstraints { (mk) in
            mk.edges.equalToSuperview()
        }
        
        lbPhone = label(22, .GRAY, .left).text("手机号")
        avatarView.addSubview(lbPhone)
        lbPhone.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.right.equalTo(ivAvatar.snp.left).offset(-12)
            mk.top.equalTo(ivAvatar.snp.top)
            mk.height.equalTo(50)
        }
        
        let lbT1 = label(18, .YELLOW, .left).text("更换头像")
        avatarView.addSubview(lbT1)
        lbT1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.top.equalTo(lbPhone.snp.bottom)
            mk.height.equalTo(30)
            mk.right.equalTo(lbPhone)
        }
        
        let (vName, tfName) = addEditView(topView: lbT1, lbName: "姓名", placeholder: "输入姓名")
        self.tfName = tfName
        let (vEmail, tfEmail) = addEditView(topView: vName, lbName: "电子邮箱", placeholder: "输入电子邮箱")
        self.tfEmail = tfEmail
        self.tfEmail.keyboardType = .emailAddress
        let (vAddress, tfAddress) = addTextView(topView: vEmail, lbName: "详细地址", placeholder: "输入详细地址", tag: 0)
        self.tfAddress = tfAddress
        
        let lb2 = label(30, .BLACK, .left).text("选填内容")
        contentView.addSubview(lb2)
        lb2.snp.makeConstraints { (mk) in
            mk.top.equalTo(vAddress.snp.bottom).offset(30)
            mk.left.right.equalToSuperview()
            mk.height.equalTo(40)
        }
        
        let (vEmName, tfEmName) = addEditView(topView: lb2, lbName: "紧急联系人", placeholder: "输入姓名")
        self.tfEmName = tfEmName
        let (vEmPhone, tfEmPhone) = addEditView(topView: vEmName, lbName: "紧急联系人电话", placeholder: "输入联系电话")
        self.tfEmPhone = tfEmPhone
        self.tfEmPhone.keyboardType = .phonePad
        let (vIncome, tfIncome) = addEditView(topView: vEmPhone, lbName: "收入", placeholder: "输入收入")
        self.tfIncome = tfIncome
        self.tfIncome.keyboardType = .decimalPad
        let (vInfoFrom, tfInfoFrom) = addTextView(topView: vIncome, lbName: "信息来源", placeholder: "输入信息来源", tag: 1)
        self.tfInfoFrom = tfInfoFrom
        let (_, tfUse) = addTextView(topView: vInfoFrom, lbName: "租车用途", placeholder: "输入租车用途", tag: 2)
        self.tfUse = tfUse
        
        calculateContentHeight()
        
        initProgressView { (mk) in
            mk.left.right.bottom.equalToSuperview()
            mk.top.equalTo(header!.snp.bottom)
        }
    }
    
    @objc func clickSubmit() {
        hideKeyboard()
        //TODO: 保存
        
        if (user.avatar ?? "").count < 1 && imgUploadStr.count < 1 {
            showToast(msg: "请选择头像")
            return
        }
        
        let name = tfName.text ?? ""
        if name.count < 1 { showToast(msg: "请输入姓名"); return;}
        let email = tfEmail.text ?? ""
        if email.count < 1 { showToast(msg: "请输入邮箱"); return;}
        let address = tfAddress.text ?? ""
        if address.count < 1 { showToast(msg: "请输入详细地址"); return;}
        let emName = tfEmName.text ?? ""
        let emPhone = tfEmPhone.text ?? ""
        let income = tfIncome.text ?? ""
        let infoFrom = tfInfoFrom.text ?? ""
        let use = tfUse.text ?? ""
        
        showPb()
        
        let params = ["name": name,
                      "email": email,
                      "address": address,
                      "emName": emName,
                      "emPhone": emPhone,
                      "income": income,
                      "infoFrom": infoFrom,
                      "use": use]
        RentCarProvider.request(.call("Pro_WL_MoblieLoad", params)) { (result) in
            switch result {
            case let .success(response):
                NSLog.i(try? response.mapString())
                break
            case let .failure(error):
                NSLog.e(error)
                break
            }
            self.hidePb()
        }
    }
    
    func loadData() {
        user = UserDefaults.getUserInfo()
        lbPhone.text = user.phone?.toPhone()
        
        ivAvatar.kf.setImage(with: URL(string: user.avatar!), placeholder: UIImage(color: .GRAY_BG)?.toCircle(), options: nil, progressBlock: nil) { (image, error, type, url) in
            if (error == nil || error!.code == 0) && image != nil {
                // 成功
                self.lbAvatar.isHidden = true
                self.ivAvatar.image = image?.toCircle()
            } else {
                self.lbAvatar.isHidden = false
            }
        }
        tfName.text = user.name
        tfEmail.text = user.email
        tfAddress.text = user.address
        tfEmName.text = user.emergencyName
        tfEmPhone.text = user.emergencyPhone
        tfIncome.text = user.income
        tfInfoFrom.text = user.infoFrom
        tfUse.text = user.use
        
        calculateTextViewHeight(tfAddress)
        calculateTextViewHeight(tfInfoFrom)
        calculateTextViewHeight(tfUse)
    }
    
    //MARK:- 更换头像
    @objc func clickAvatar() {
        hideKeyboard()
        
        showPhotoPicker(delegate: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let type: String = (info[UIImagePickerController.InfoKey.mediaType] as! String)
        
        //当选择的类型是图片
        if type == "public.image"
        {
            //修正图片的位置
            let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage).fixOrientation()
            //先把图片转成NSData
            let data = image.jpegData(compressionQuality: 0.8)
            imgUploadStr = data?.base64EncodedString() ?? ""
            
            ivAvatar.image = UIImage(data: data!)!.toCircle()
            
            // 关闭picker
            picker.dismiss(animated: true, completion: nil)
        } else {
            showToast(msg: "请选择图片")
        }
    }
    
    //MARK:- 输入框
    func addEditView(topView: UIView, lbName: String, placeholder: String) -> (UIView, UITextField) {
        let ev = UIView()
        
        let lb = label(18, .GRAY, .left).text(lbName)
        ev.addSubview(lb)
        lb.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalToSuperview().offset(20)
            mk.height.equalTo(30)
        }
        
        let tf = tField(20, .BLACK, placeholder)
        tf.delegate = self
        tf.clearButtonMode = .always
        ev.addSubview(tf)
        tf.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(40)
            mk.top.equalTo(lb.snp.bottom).offset(5)
        }
        
        let l1 = line()
        ev.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(tf.snp.bottom).offset(15)
            mk.height.equalTo(0.5)
        }
        
        contentView.addSubview(ev)
        ev.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(topView.snp.bottom)
            mk.height.equalTo(110.5)
        }
        return (ev, tf)
    }
    
    func addTextView(topView: UIView, lbName: String, placeholder: String, tag: Int) -> (UIView, UITextView) {
        let ev = UIView()
        
        let lb = label(18, .GRAY, .left).text(lbName)
        ev.addSubview(lb)
        lb.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalToSuperview().offset(20)
            mk.height.equalTo(30)
        }
        
        let tf = tFieldMult(20, .BLACK)
        tf.placeholder = placeholder
        tf.tag = tag
        tf.isScrollEnabled = false
        tf.delegate = self
        ev.addSubview(tf)
        tf.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(40)
            mk.top.equalTo(lb.snp.bottom).offset(5)
        }
        
        let l1 = line()
        ev.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(tf.snp.bottom).offset(15)
            mk.height.equalTo(0.5)
        }
        
        contentView.addSubview(ev)
        ev.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(topView.snp.bottom)
            mk.height.equalTo(110.5)
        }
        return (ev, tf)
    }
    
    //MARK:- 输入框监听
    func textViewDidChange(_ textView: UITextView) {
        calculateTextViewHeight(textView)
    }
    
    override func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        lastHeights[textView.tag] = getStrHeight(labelStr: textView.text ?? "", font: textView.font!, width: contentWidth)
        return super.textViewShouldBeginEditing(textView)
    }
    
    func calculateTextViewHeight(_ textView: UITextView) {
        var h = getStrHeight(labelStr: textView.text ?? "", font: textView.font!, width: contentWidth)
        if h < 40 {
            h = 40
        }
        if lastHeights[textView.tag] != h {
            // 高度发生变化
            textView.snp.updateConstraints { (mk) in
                mk.height.equalTo(h)
            }
            textView.superview!.snp.updateConstraints { (mk) in
                mk.height.equalTo(70.5 + h)
            }
            lastHeights[textView.tag] = h
            
            calculateContentHeight()
        }
    }
    //MARK:- 重新计算ScrollView内容高度
    func calculateContentHeight() {
        var tvHeight: CGFloat = 0
        for i in 0...2 {
            tvHeight = tvHeight + lastHeights[i] + 70.5
        }
        contentHeight = 240 + (5 * 110.5) + tvHeight
        
        contentView.snp.updateConstraints { (mk) in
            mk.left.top.equalToSuperview()
            mk.width.equalTo(contentWidth)
            mk.height.equalTo(contentHeight)
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
}
