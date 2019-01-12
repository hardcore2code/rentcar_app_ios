//
//  CommonUtil.swift
//  EasyStuff
//
//  Created by Static on 02/03/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation
import Toaster

/**
 显示Toast
 msg: 消息
 */
func showToast(msg: String!) {
    Toast(text: msg).show()
}

/**
 显示Toast
 localKey: 国际化KEY
 */
func showToast(localKey: String!) {
    Toast(text: localizedString(key: localKey)).show()
}

/**
 本地化语言
 */
func localizedString(key: String!) -> String {
    return NSLocalizedString(key, comment: key)
}

/**
 Double转String，如果小数位为0，去掉小数点
*/
func deleteZeroAfterDot(double value: Double) -> String {
    let str = String(value)
    let strs = str.split(separator: ".")
    if Int(strs[1]) == 0 {
        return String(strs[0])
    }
    
    return str
}

/**
 Float转String，如果小数位为0，去掉小数点
 */
func deleteZeroAfterDot(float value: Float) -> String {
    return deleteZeroAfterDot(double: Double(value))
}

// MARK: - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
func getFirstLetterFromString(aString: String) -> String {
    
    // 注意,这里一定要转换成可变字符串
    let mutableString = NSMutableString.init(string: aString)
    // 将中文转换成带声调的拼音
    CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
    // 去掉声调(用此方法大大提高遍历的速度)
    let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
    // 将拼音首字母装换成大写
    let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
    // 截取大写首字母
    let firstString = (strPinYin as NSString).substring(to: 1)
    // 判断姓名首位是否为大写字母
    let regexA = "^[A-Z]$"
    let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
    return predA.evaluate(with: firstString) ? firstString : "#"
}

/// 多音字处理
func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
    if nameString.hasPrefix("长") {return "chang"}
    if nameString.hasPrefix("沈") {return "shen"}
    if nameString.hasPrefix("厦") {return "xia"}
    if nameString.hasPrefix("地") {return "di"}
    if nameString.hasPrefix("重") {return "zhong"}
    
    return pinyinString;
}

/// 格式化数字
func formateNumbers(nums: Double) -> String {
    if nums < 1000 {
        return String(nums)
    }
    let format = NumberFormatter()
    format.numberStyle = .decimal
    return format.string(from: NSNumber(value: nums))!
}


/// 公历转阴历
///
/// - Parameter date: 公历日期
/// - Returns: 阴历日期
func transformSolar2Lunar(_ date: Date) -> String {
    // 公历日历
    let gregorian = Calendar(identifier: .gregorian)
    
    //设置为12点
    var components = DateComponents()
    components.timeZone = TimeZone(secondsFromGMT: 60 * 60 * 8)
    let solarDate = gregorian.date(byAdding: components, to: date)
    
    // 设置农历日历
    let chineseCalendar = Calendar(identifier: .chinese)
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    formatter.calendar = chineseCalendar
    formatter.dateStyle = .full
    
    return formatter.string(from: solarDate!)
}

let OLD_HOUR = ["子时(三更)", "丑时(四更)", "寅时(五更)", "卯时"
                , "辰时", "巳时", "午时", "未时"
                , "申时", "酉时", "戌时(一更)", "亥时(二更)"]

let OLD_YEAR = ["鼠", "牛", "虎", "兔"
                , "龙", "蛇", "马", "羊"
                , "猴", "鸡", "狗", "猪"]

let OLD_NUM = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
/// 获取时辰
func transformHour2Old(hour: Int, minute: Int) -> String {
    var hh = hour
    var mm = minute / 15
    if hour % 2 == 1 {
        hh += 1
    } else {
        mm += 4 // 一小时分四刻
    }

    return OLD_HOUR[hh / 2 % 12] + (mm > 0 ? (OLD_NUM[mm] + "刻") : "")
}


/// 获取生肖
func transformYear2Old(yearInChinese: Int) -> String {
    return OLD_YEAR[(yearInChinese - 1) % 12]
}

func transformYear2Old(date: Date) -> String {
    return transformYear2Old(yearInChinese: getTimeDetailChinese(date).year!)
}

/// 获取指定时间
func getTimeDetail(_ date: Date = Date()) -> DateComponents {
    let calendar = Calendar(identifier: .gregorian)
    var comps = DateComponents()
    comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    return comps
}

/// 获取农历指定时间
func getTimeDetailChinese(_ date: Date = Date()) -> DateComponents {
    let calendar = Calendar(identifier: .chinese)
    var comps = DateComponents()
    comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    return comps
}

/// 通过公历年月日输出时间
/// 如：2018年4月3日星期六
func getDateBy(year: Int, month: Int, day: Int) -> String {
    let calendar = Calendar(identifier: .gregorian)
    var comps = DateComponents()
    comps.year = year
    comps.month = month
    comps.day = day
    let date = calendar.date(from: comps)!
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    formatter.calendar = calendar
    formatter.dateStyle = .full
    return formatter.string(from: date)
}
