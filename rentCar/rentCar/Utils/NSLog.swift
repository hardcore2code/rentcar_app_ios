//
//  NSString.swift
//  EasyStuff
//
//  Created by Static on 12/02/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation

class NSLog {
    /**
     打印错误信息
     */
    static func e(_ any: Any!) {
        if FORCE_LOG {
            print("Error(NSLog): \(any ?? "")")
        }
    }
    
    /**
     打印警告信息
     */
    static func w(_ any: Any!) {
        if FORCE_LOG {
            print("Warning(NSLog): \(any ?? "")")
        }
    }
    
    /**
     打印正常信息
     */
    static func i(_ any: Any!) {
        if FORCE_LOG {
            print("Info(NSLog): \(any ?? "")")
        }
    }
}
