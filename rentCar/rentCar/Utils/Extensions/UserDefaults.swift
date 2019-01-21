//
//  UserDefaultKeys.swift
//  EasyStuff
//
//  Created by Static on 14/02/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let UK_PHONE: String = "UK_PHONE"
    static let UK_NAME: String = "UK_NAME"
    static let UK_AVATAR: String = "UK_AVATAR"
    static let UK_PWD: String = "UK_PWD"
    
    static let UK_EMAIL: String = "UK_EMAIL"
    static let UK_ADDRESS: String = "UK_ADDRESS"
    static let UK_EMNAME: String = "UK_EMNAME"
    static let UK_EMPHONE: String = "UK_EMHONE"
    static let UK_INCOME: String = "UK_INCOME"
    static let UK_INFO_FROM: String = "UK_INFO_FROM"
    static let UK_USE: String = "UK_USE"
    
    static let UK_STEP: String = "UK_STEP"
    
    static func setStr(_ key: String, _ value: String) {
        UserDefaults.standard.set(value.data(using: .utf8), forKey: key)
    }
    
    static func getStr(_ key: String) -> String {
        let data = UserDefaults.standard.data(forKey: key)
        if data == nil {
            return ""
        } else {
            return String(data: data!, encoding: .utf8) ?? ""
        }
    }
    
    static func setInt(_ key: String, _ value: Int) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getInt(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func setBool(_ key: String, _ value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    static func getUserInfo() -> UserInfo {
        let user = UserInfo()
        
        user.phone = UserDefaults.getStr(UserDefaults.UK_PHONE)
        user.name = UserDefaults.getStr(UserDefaults.UK_NAME)
        user.avatar = UserDefaults.getStr(UserDefaults.UK_AVATAR)
        user.pwd = UserDefaults.getStr(UserDefaults.UK_PWD)
        
        user.email = UserDefaults.getStr(UserDefaults.UK_EMAIL)
        user.address = UserDefaults.getStr(UserDefaults.UK_ADDRESS)
        user.emergencyName = UserDefaults.getStr(UserDefaults.UK_EMNAME)
        user.emergencyPhone = UserDefaults.getStr(UserDefaults.UK_EMPHONE)
        user.income = UserDefaults.getStr(UserDefaults.UK_INCOME)
        user.infoFrom = UserDefaults.getStr(UserDefaults.UK_INFO_FROM)
        user.use = UserDefaults.getStr(UserDefaults.UK_USE)
        
        user.todoSteps = UserDefaults.getInt(UserDefaults.UK_STEP)
        
        return user
    }
    
    static func setUserInfo(_ user: UserInfo) {
        UserDefaults.setStr(UserDefaults.UK_PHONE, user.phone ?? "")
        UserDefaults.setStr(UserDefaults.UK_NAME, user.name ?? "未设置")
        UserDefaults.setStr(UserDefaults.UK_AVATAR, user.avatar ?? "")
        UserDefaults.setStr(UserDefaults.UK_PWD, user.pwd ?? "")
        
        UserDefaults.setStr(UserDefaults.UK_EMAIL, user.email ?? "")
        UserDefaults.setStr(UserDefaults.UK_ADDRESS, user.address ?? "")
        UserDefaults.setStr(UserDefaults.UK_EMNAME, user.emergencyName ?? "")
        UserDefaults.setStr(UserDefaults.UK_EMPHONE, user.emergencyPhone ?? "")
        UserDefaults.setStr(UserDefaults.UK_INCOME, user.income ?? "")
        UserDefaults.setStr(UserDefaults.UK_INFO_FROM, user.infoFrom ?? "")
        UserDefaults.setStr(UserDefaults.UK_USE, user.use ?? "")
        
        UserDefaults.setInt(UserDefaults.UK_STEP, user.todoSteps)
    }
}
