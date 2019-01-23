//
//  MineViewController.swift
//  rentCar
//
//  Created by Static on 2019/1/11.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class MineViewController: BaseViewController {
    private var funcs       = ["我的账户", "我的订单", "我的卡券", "实名认证", "用车手册", "热线电话", "邀请好友", "关于我们", "设置密码", "修改手机号"]
    private var needLogins  = [true, true, true, true, false, false, true, false, true, true]
    private var icons       = ["ic_account", "ic_order", "ic_coupon", "ic_verify", "ic_readme", "ic_line", "ic_friends", "ic_about_us", "ic_set_pwd", "ic_set_phone"]
    private var funcViews: [UIView] = []
    
    private var user: UserInfo!
    private var isLogin: Bool!

    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var lbName: UILabel!
    private var ivAvatar: UIImageView!
    private var lbAvatar: UILabel!
    
    private var stepView: UIView!
    private var lbStep: UILabel!
    private var steps: [UIView]!
    private var step1: UIView!
    private var step2: UIView!
    private var step3: UIView!
    private var step4: UIView!
    
    private var stepHeight: CGFloat!
    private var contentHeight: CGFloat!
    private var contentWidth: CGFloat!
    private let funcHeight: CGFloat = 80
    
    override func viewDidLoad() {
        isGestureEnable = false
        super.viewDidLoad()
        
        initView()
        loadData()
    }
    
    func initView() {
        addFooter()
        
        contentWidth = screenWidth - horizontalMargin * 2
        
        scrollView = UIScrollView().normalVertical()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview().offset(horizontalMargin)
            mk.right.equalToSuperview().offset(-horizontalMargin)
            mk.top.equalToSuperview().offset(22)
            mk.bottom.equalTo(footer!.snp.top)
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        let avatarView = UIView()
        avatarView.tag = 90
        avatarView.setOnClickListener(target: self, action: #selector(self.clickFunc(sender:)))
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalToSuperview().offset(32)
            mk.height.equalTo(90)
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
        
        lbName = label(30, .BLACK, .left).text("未登录")
        avatarView.addSubview(lbName)
        lbName.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.right.equalTo(ivAvatar.snp.left).offset(-12)
            mk.top.equalTo(ivAvatar.snp.top)
            mk.height.equalTo(60)
        }
        
        let lbT1 = label(18, .GRAY, .left).text("查看并编辑个人资料")
        avatarView.addSubview(lbT1)
        lbT1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.top.equalTo(lbName.snp.bottom)
            mk.height.equalTo(30)
            mk.right.equalTo(lbName)
        }
        
        stepView = UIView()
        stepView.tag = 91
        stepView.setOnClickListener(target: self, action: #selector(self.clickFunc(sender:)))
        stepView.clipsToBounds = true
        contentView.addSubview(stepView)
        
        lbStep = label(24, .GRAY, .left).text("还有3步")
        stepView.addSubview(lbStep)
        lbStep.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalToSuperview().offset(30)
            mk.height.equalTo(40)
        }
        
        step1 = UIView().corner(rect: CGRect(x: 0, y: 0, width: contentWidth * 0.25 , height: 48), byRoundingCorners: [.topLeft, .bottomLeft])
        step1.backgroundColor = .GRAY_BG
        stepView.addSubview(step1)
        step1.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.top.equalTo(lbStep.snp.bottom).offset(12)
            mk.width.equalToSuperview().multipliedBy(0.24)
            mk.height.equalTo(48)
        }
        
        step2 = UIView()
        step2.backgroundColor = .GRAY_BG
        stepView.addSubview(step2)
        step2.snp.makeConstraints { (mk) in
            mk.left.equalTo(step1.snp.right).offset(contentWidth * 0.01)
            mk.width.equalTo(contentWidth * 0.24)
            mk.top.height.equalTo(step1)
        }
        
        step3 = UIView()
        step3.backgroundColor = .GRAY_BG
        stepView.addSubview(step3)
        step3.snp.makeConstraints { (mk) in
            mk.left.equalTo(step2.snp.right).offset(contentWidth * 0.01)
            mk.top.height.width.equalTo(step2)
        }
        
        step4 = UIView().corner(rect: CGRect(x: 0, y: 0, width: contentWidth * 0.24, height: 48), byRoundingCorners: [.topRight, .bottomRight])
        step4.backgroundColor = .GRAY_BG
        stepView.addSubview(step4)
        step4.snp.makeConstraints { (mk) in
            mk.left.equalTo(step3.snp.right).offset(contentWidth * 0.01)
            mk.right.equalToSuperview()
            mk.top.height.equalTo(step1)
        }
        
        steps = [step1, step2, step3, step4]
        
        let lbT2 = labelLines(18, .GRAY, .left).text("我们要求每一位用户在租用或下单之前提供一些具体信息，现在就先来完成这一步吧")
        let t2Height = getStrHeight(labelStr: lbT2.text!, font: lbT2.font, width: contentWidth * 2 / 3)
        stepView.addSubview(lbT2)
        lbT2.snp.makeConstraints { (mk) in
            mk.left.equalToSuperview()
            mk.top.equalTo(step1.snp.bottom).offset(20)
            mk.width.equalTo(contentWidth * 2 / 3)
            mk.height.equalTo(t2Height)
        }
        
        let iv2 = UIImageView(image: UIImage(named: "arrow_right")?.tint(color: .GRAY_LINE))
        iv2.contentMode = .scaleAspectFit
        stepView.addSubview(iv2)
        iv2.snp.makeConstraints { (mk) in
            mk.width.height.equalTo(32)
            mk.right.equalToSuperview()
            mk.centerY.equalTo(lbT2)
        }
        
        stepHeight = 150 + t2Height
        stepView.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.top.equalTo(lbT1.snp.bottom)
            mk.height.equalTo(stepHeight)
        }
        
        let l1 = line()
        contentView.addSubview(l1)
        l1.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(0.5)
            mk.top.equalTo(stepView.snp.bottom).offset(30)
        }
        
        for i in 0...(funcs.count - 1) {
            let topView = i == 0 ? l1 : funcViews[i - 1]
            funcViews.append(getFuncView(tag: i, topView: topView, funcName: funcs[i], icon: icons[i]))
        }
        
        contentHeight = 152.5 + stepHeight + funcHeight * CGFloat(funcs.count) + funcHeight
        contentView.snp.makeConstraints { (mk) in
            mk.left.top.equalToSuperview()
            mk.width.equalTo(contentWidth)
            mk.height.equalTo(contentHeight)
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    func loadData() {
        user = UserDefaults.getUserInfo()
        isLogin = (user.phone?.count ?? 0) > 1
        
        updateUI()
    }
    
    //MARK:- 加载用户数据
    private func updateUI() {
        lbName.text = isLogin ? (user.name!.count > 1 ? user.name : "未设置") : "未登录"
        ivAvatar.kf.setImage(with: URL(string: user.avatar!), placeholder: UIImage(color: .GRAY_BG)?.toCircle(), options: nil, progressBlock: nil) { (image, error, type, url) in
            if (error == nil || error!.code == 0) && image != nil {
                // 成功
                self.lbAvatar.isHidden = true
                self.ivAvatar.image = image?.toCircle()
            } else {
                self.lbAvatar.isHidden = false
            }
        }
        
        let stepTodo = user.todoSteps
        let sh = isLogin && stepTodo > 0 ? stepHeight : 0
        contentHeight = 152.5 + sh! + funcHeight * CGFloat(funcs.count) + funcHeight
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        if isLogin && stepTodo > 0 {
            // 有未完成的步骤
            lbStep.text = "还有\(stepTodo)步"
            for i in 0...3 {
                steps[i].backgroundColor = i < (4 - stepTodo) ? .YELLOW : .GRAY_BG
            }
        }
        
        stepView.snp.updateConstraints { (mk) in
            mk.height.equalTo(sh!)
        }
        contentView.snp.updateConstraints { (mk) in
            mk.height.equalTo(contentHeight!)
        }
    }
    
    //MARK:- 功能菜单
    private func getFuncView(tag: Int, topView: UIView, funcName: String, icon: String) -> UIView {
        let funcView = UIView()
        funcView.tag = tag
        
        let iv = UIImageView(image: UIImage(named: "arrow_right")?.tint(color: .GRAY_LINE))
        iv.contentMode = .scaleAspectFit
        funcView.addSubview(iv)
        iv.snp.makeConstraints { (mk) in
            mk.right.equalToSuperview()
            mk.width.height.equalTo(32)
            mk.centerY.equalToSuperview()
        }
        
        let lb = label(20, .GRAY, .left).text(funcName)
        funcView.addSubview(lb)
        lb.snp.makeConstraints { (mk) in
            mk.left.centerY.equalToSuperview()
            mk.height.equalTo(30)
            mk.right.equalTo(iv.snp.left).offset(padding)
        }
        
        let l = line()
        funcView.addSubview(l)
        l.snp.makeConstraints { (mk) in
            mk.left.right.bottom.equalToSuperview()
            mk.height.equalTo(0.5)
        }
        
        contentView.addSubview(funcView)
        funcView.snp.makeConstraints { (mk) in
            mk.left.right.equalToSuperview()
            mk.height.equalTo(80)
            mk.top.equalTo(topView.snp.bottom)
        }
        
        funcView.setOnClickListener(target: self, action: #selector(self.clickFunc(sender:)))
        
        return funcView
    }
    
    func goLogin() {
        self.navigationController?.pushViewController(LoginPhoneViewController(), animated: true)
    }
    
    //MARK:- 功能菜单点击事件
    @objc func clickFunc(sender: UITapGestureRecognizer) {
        let tag = (sender.view?.tag)!
        NSLog.e("点击功能tag ：\(tag)")
        switch tag {
        case 0...(funcs.count - 1):
            if needLogins[tag] && !isLogin {
                // 未登录
                goLogin()
                return
            }
            break
        case 90...91:
            if !isLogin {
                // 未登录
                goLogin()
                return
            }
            break
        default:
            return
        }
        
        switch sender.view?.tag {
        case 90:
            // 点击编辑用户信息
            self.navigationController?.pushViewController(EditViewController(), animated: true)
            break
        case 91:
            // 点击步骤
            //TODO: 退出登录
            UserDefaults.setStr(UserDefaults.UK_PHONE, "")
            UserDefaults.setStr(UserDefaults.UK_AVATAR, "")
            loadData()
            break
        case 0:
            // 我的账户
            break
        case 1:
            // 我的订单
            break
        case 2:
            // 我的卡券
            break
        case 3:
            // 实名认证
            break
        case 4:
            // 用车手册
            break
        case 5:
            // 热线电话
            break
        case 6:
            // 邀请好友
            break
        case 7:
            // 关于我们
            break
        case 8:
            // 设置密码
            break
        case 9:
            // 修改手机号
            break
        default:
            break
        }
    }
}
