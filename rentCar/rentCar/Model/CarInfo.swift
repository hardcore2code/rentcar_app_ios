//
//  CarInfo.swift
//  rentCar
//
//  Created by Static on 2019/1/14.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation

class CarInfo: NSObject {
    var id: String?
    var name: String?
    var brand: String?
    var company: String?
    var price: String?
    var priceOld: String?
    var sub: String?
    var type: String?
    var power: String?
    var sit: String?
    var length: String?
    var weight: String?
    var charge: String?
    var phone: String?
    
    var loc1: String?
    var loc2: String?
    var longitude: Double?
    var latitude: Double?
    
    var imgList: [String] = []
    var commentList: [CommentInfo] = []
}
