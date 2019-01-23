//
//  LoginCodeViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/22.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class LoginCodeViewController: BaseViewController {

    private var lbPhone: UILabel!
    private var btnSend: UILabel!
    private var tfCode: UITextField!
    var phone: String!
    
    var timer: Timer?
    var seconds = CODE_TIME_INTERVAL
    
    override func viewDidLoad() {
        isEditExisted = true
        super.viewDidLoad()
        
        initView()
        startTimer()
    }
    
    func initView() {
        self.view.backgroundColor = .YELLOW
        addHeader(true)
        
        let lb1 = label(30, .WHITE, .left).text("输入6位验证码")
        self.view.addSubview(lb1)
        lb1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalTo(header!.snp.bottom).offset(30)
            mk.height.equalTo(40)
        }
        
        lbPhone = label(20, .WHITE, .left).text("我们向\(phone!.toPhone())发送了一个验证码，请在下方输入。")
        self.view.addSubview(lbPhone)
        lbPhone.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.top.equalTo(lb1.snp.bottom).offset(20)
            mk.height.equalTo(30)
        }
        
        let lb = label(18, .WHITE, .left).text("验证码")
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.top.equalTo(lbPhone.snp.bottom).offset(20)
            mk.height.equalTo(30)
        }
        
        tfCode = tField(20, .WHITE, "输入验证码").setPlaceholder(.GRAY_TRANS)
        tfCode.keyboardType = .numberPad
        tfCode.clearButtonMode = .always
        self.view.addSubview(tfCode)
        tfCode.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.height.equalTo(40)
            mk.top.equalTo(lb.snp.bottom).offset(5)
        }
        
        let l1 = line()
        l1.backgroundColor = .WHITE
        self.view.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.top.equalTo(tfCode.snp.bottom).offset(15)
            mk.height.equalTo(0.5)
        }
        
        btnSend = label(18, .WHITE, .center).text("重新获取")
        btnSend.setOnClickListener(target: self, action: #selector(self.clickSend))
        self.view.addSubview(btnSend)
        btnSend.snp.makeConstraints { (mk) in
            mk.height.equalTo(30)
            mk.centerY.equalTo(lb)
            mk.right.equalToSuperview().offset(-padding)
            mk.width.equalTo(getLabelWidth(btnSend, 30) + 20)
        }
        
        setInputLengthLimit(tfs: [(tfCode, 6)])
        initProgressView { (mk) in
            mk.left.right.bottom.equalToSuperview()
            mk.top.equalTo(header!.snp.bottom)
        }
    }
    
    //MARK:- 倒计时
    func startTimer() {
        seconds = CODE_TIME_INTERVAL
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
        timer!.fire()
    }
    
    @objc private func updateTime() {
        if seconds > 1 {
            btnSend.text = "\(seconds)s"
            btnSend.isUserInteractionEnabled = false
            btnSend.textColor = .GRAY_TRANS
            seconds -= 1
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        btnSend.text = "重新获取"
        btnSend.isUserInteractionEnabled = true
        btnSend.textColor = .WHITE
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 页面消失时，停止倒计时
        stopTimer()
    }
    
    //MARK:- 发送验证码
    @objc func clickSend() {
        showPb()
        
        NetUtil.request(.call("", [:])) { (result) in
            switch result {
            case let .success(response):
                let data = try? response.mapString()
                NSLog.i("response : \(data!)")
                self.startTimer()
                break
            case let .failure(error):
                NSLog.e("\(error)")
                break
            }
            
            self.hidePb()
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let txt = textField.text else {
            return true
        }
        
        let length = txt.count + string.count - range.length
        if length == 6 {
            checkCode()
        }
        
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    //MARK:- 验证短信
    func checkCode() {
        hideKeyboard()
        
        showPb()
        
        NetUtil.request(.call("", [:])) { (result) in
            switch result {
            case let .success(response):
                let data = try? response.mapString()
                NSLog.i("reponse:\(data!)")
                self.loginSuc()
                break
            case let .failure(error):
                NSLog.e("\(error)")
                break
            }
            
            self.hidePb()
        }
    }
    
    //MARK:- 登入成功
    func loginSuc() {
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
