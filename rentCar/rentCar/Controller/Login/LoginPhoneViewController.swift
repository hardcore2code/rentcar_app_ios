//
//  LoginPhoneViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/22.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class LoginPhoneViewController: BaseViewController {

    private var tfPhone: UITextField!
    
    override func viewDidLoad() {
        isEditExisted = true
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        self.view.backgroundColor = .YELLOW
        addHeader(true)
        
        let lb1 = label(30, .WHITE, .left).text("手机验证码登录")
        self.view.addSubview(lb1)
        lb1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalTo(header!.snp.bottom).offset(30)
            mk.height.equalTo(40)
        }
        
        let lb = label(18, .WHITE, .left).text("手机号")
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.top.equalTo(lb1.snp.bottom).offset(20)
            mk.height.equalTo(30)
        }
        
        tfPhone = tField(20, .WHITE, "输入手机号").setPlaceholder(.GRAY_TRANS)
        tfPhone.keyboardType = .numberPad
        tfPhone.clearButtonMode = .always
        self.view.addSubview(tfPhone)
        tfPhone.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.height.equalTo(40)
            mk.top.equalTo(lb.snp.bottom).offset(5)
        }
        
        let l1 = line()
        l1.backgroundColor = .WHITE
        self.view.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.top.equalTo(tfPhone.snp.bottom).offset(15)
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
        
        let btnMore = label(20, .WHITE, .center).text("更多方式")
        btnMore.setOnClickListener(target: self, action: #selector(self.clickMore))
        self.view.addSubview(btnMore)
        btnMore.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.width.equalTo(getLabelWidth(btnMore, 40) + (horizontalMargin * 2))
            mk.height.equalTo(40)
            mk.centerY.equalTo(vGo)
        }
        
        setInputLengthLimit(tfs: [(tfPhone, 11)])
    }
    
    @objc func clickGo() {
        hideKeyboard()
        
        let phone = tfPhone.text ?? ""
        if phone.count < 11 {
            showToast(msg: "请输入正确的手机号")
            return
        }
        
        let codeVc = LoginCodeViewController()
        codeVc.phone = phone
        self.navigationController?.pushViewController(codeVc, animated: true)
    }
    
    //MARK:- 其他方式登录
    @objc func clickMore() {
        self.navigationController?.pushViewController(LoginTypeViewController(), animated: true)
    }
}
