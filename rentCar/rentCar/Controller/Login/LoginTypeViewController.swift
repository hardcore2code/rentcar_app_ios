//
//  LoginTypeViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/23.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

class LoginTypeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        self.view.backgroundColor = .YELLOW
        addHeader(true)
        
        let lb1 = label(30, .WHITE, .left).text("更多方式")
        self.view.addSubview(lb1)
        lb1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalTo(header!.snp.bottom).offset(30)
            mk.height.equalTo(40)
        }
        
        let btnAccount = label(22, .WHITE, .center).toButton(.GREEN_LIGHT).text("帐号密码")
        self.view.addSubview(btnAccount)
        btnAccount.setOnClickListener(target: self, action: #selector(self.clickAccount))
        btnAccount.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(lb1)
            mk.height.equalTo(48)
            mk.top.equalTo(lb1.snp.bottom).offset(30)
        }
        
        let btnWechat = label(22, .WHITE, .center).toButton(.GREEN_LIGHT).text("微信登录")
        self.view.addSubview(btnWechat)
        btnWechat.setOnClickListener(target: self, action: #selector(self.clickWechat))
        btnWechat.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(btnAccount)
            mk.height.equalTo(48)
            mk.top.equalTo(btnAccount.snp.bottom).offset(30)
        }
    }

    @objc func clickAccount() {
        self.navigationController?.pushViewController(LoginAccountViewController(), animated: true)
    }
    
    @objc func clickWechat() {
        showToast(msg: "敬请期待")
    }
}
