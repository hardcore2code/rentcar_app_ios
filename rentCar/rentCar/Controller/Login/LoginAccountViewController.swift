//
//  LoginAccountViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/23.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class LoginAccountViewController: BaseViewController {
    
    private var tfPhone: UITextField!
    private var tfPwd: UITextField!

    override func viewDidLoad() {
        isEditExisted = true
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        self.view.backgroundColor = .YELLOW
        addHeader(true)
        
        let lbTitle = label(30, .WHITE, .left).text("手机登录")
        self.view.addSubview(lbTitle)
        lbTitle.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalTo(header!.snp.bottom).offset(30)
            mk.height.equalTo(40)
        }
        
        let lbPhone = label(18, .WHITE, .left).text("手机号")
        self.view.addSubview(lbPhone)
        lbPhone.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbTitle)
            mk.top.equalTo(lbTitle.snp.bottom).offset(20)
            mk.height.equalTo(30)
        }
        
        tfPhone = tField(20, .WHITE, "输入手机号").setPlaceholder(.GRAY_TRANS)
        tfPhone.keyboardType = .numberPad
        tfPhone.clearButtonMode = .always
        self.view.addSubview(tfPhone)
        tfPhone.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbTitle)
            mk.height.equalTo(40)
            mk.top.equalTo(lbPhone.snp.bottom).offset(5)
        }
        
        let lPhone = line()
        lPhone.backgroundColor = .WHITE
        self.view.addSubview(lPhone)
        lPhone.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbTitle)
            mk.top.equalTo(tfPhone.snp.bottom).offset(15)
            mk.height.equalTo(0.5)
        }
        
        let lbPwd = label(18, .WHITE, .left).text("密码")
        self.view.addSubview(lbPwd)
        lbPwd.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbTitle)
            mk.top.equalTo(lPhone.snp.bottom).offset(20)
            mk.height.equalTo(30)
        }
        
        tfPwd = tField(20, .WHITE, "输入密码").setPlaceholder(.GRAY_TRANS)
        tfPwd.keyboardType = .default
        tfPwd.isSecureTextEntry = true
        tfPwd.clearButtonMode = .always
        self.view.addSubview(tfPwd)
        tfPwd.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lbPwd)
            mk.height.equalTo(40)
            mk.top.equalTo(lbPwd.snp.bottom).offset(5)
        }
        
        let lPwd = line()
        lPwd.backgroundColor = .WHITE
        self.view.addSubview(lPwd)
        lPwd.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(tfPwd)
            mk.top.equalTo(tfPwd.snp.bottom).offset(15)
            mk.height.equalTo(0.5)
        }
        
        let vGo = UIView().corner(36)
        vGo.backgroundColor = .WHITE
        vGo.setOnClickListener(target: self, action: #selector(self.clickGo))
        self.view.addSubview(vGo)
        vGo.snp.makeConstraints { (mk) in
            mk.width.height.equalTo(72)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.bottom.equalToSuperview().offset(-padding)
        }
        
        let ivGo = UIImageView(image: UIImage(named: "arrow_right")?.tint(color: .YELLOW))
        ivGo.contentMode = .scaleAspectFit
        vGo.addSubview(ivGo)
        ivGo.snp.makeConstraints { (mk) in
            mk.center.equalToSuperview()
            mk.width.height.equalTo(36)
        }
        
        let l2 = line()
        l2.backgroundColor = .WHITE
        self.view.addSubview(l2)
        l2.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(0.5)
            mk.bottom.equalTo(vGo.snp.top).offset(-padding)
        }
        
        setInputLengthLimit(tfs: [(tfPhone, 11), (tfPwd, 20)])
        initProgressView { (mk) in
            mk.left.right.bottom.equalToSuperview()
            mk.top.equalTo(header!.snp.bottom)
        }
    }
    
    @objc func clickGo() {
        hideKeyboard()
        
        let phone = tfPhone.text ?? ""
        if phone.count < 11 {
            showToast(msg: "请输入正确的手机号")
            return
        }
        let pwd = tfPwd.text ?? ""
        if pwd.count < 1 {
            showToast(msg: "请输入密码")
            return
        }
        
        showPb()
        
        NetUtil.request(.call("", [:])) { (result) in
            switch result {
            case let .success(response):
                let data = try? response.mapString()
                NSLog.i("reponse:\(data!)")
                self.loginSuc(phone)
                break
            case let .failure(error):
                NSLog.e("\(error)")
                break
            }
            
            self.hidePb()
        }
    }
    
    //MARK:- 登入成功
    func loginSuc(_ phone: String) {
        //TODO: 登入
        UserDefaults.setStr(UserDefaults.UK_PHONE, phone)
        UserDefaults.setStr(UserDefaults.UK_AVATAR, "https://avatars0.githubusercontent.com/u/6638453?s=460&v=4")
        UserDefaults.setInt(UserDefaults.UK_STEP, 3)
        UserDefaults.setStr(UserDefaults.UK_ADDRESS, "在计算机科学中，内存中每个用于数据存取的基本单位，都被赋予一个唯一的序号，称为地址，也叫做内存地址。内存地址指系统 RAM 中的特定位置，通常以十六进制的数字表示。")
        UserDefaults.setStr(UserDefaults.UK_USE, "用来开啊，运货啊用来开啊，运货啊用来开啊，运货啊用来开啊，运货啊")
        showToast(msg: "登入成功")
        
        for vc in (self.navigationController?.viewControllers)! {
            if vc.isKind(of: MineViewController.self) {
                (vc as! MineViewController).loadData()
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}
