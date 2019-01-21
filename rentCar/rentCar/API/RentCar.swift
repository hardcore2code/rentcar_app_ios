//
//  NetProvider.swift
//  rentCar
//
//  Created by Static on 2019/1/15.
//  Copyright © 2019 Static1014. All rights reserved.
//

import Foundation
import Moya

let RentCarProvider = MoyaProvider<RentCar>()

public enum RentCar {
    case call(_ funcName: String, _ params: [String: String])
}

extension RentCar: TargetType {

    public var baseURL: URL {
        return URL(string: HOST_URL)!
    }

    public var path: String {
        return ""
    }

    public var method: Moya.Method {
        return .post
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .call(let funcName, let params):
            return .requestData(getXml(funcName: funcName, params: params).data(using: .utf8)!)
        }
    }

    /// Header
    public var headers: [String : String]? {
        return ["Content-Type": "text/xml;charset=utf-8"]
    }

    /// 获取请求参数体
    ///
    /// - Parameters:
    ///   - funcName: 接口名称
    ///   - params: 接口参数
    /// - Returns: 请求体xml
    private func getXml(funcName: String, params: [String: String]) -> String {
        var xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body>"
        xml.append(contentsOf: "<\(funcName) xmlns=\"http://tempuri.org/\">")
        for param in params {
            xml.append(contentsOf: "<\(param.key)>\(param.value)</\(param.key)>")
        }
        xml.append(contentsOf: "</\(funcName)></soap:Body></soap:Envelope>")

        NSLog.i("\(funcName) request xml: \(xml)")
        return xml
    }
}
