//
//  JIError.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation

protocol JIErrorAnalysable {
    var code: String { get }
    var message: String { get } // 原始信息
    var toast: String { get } // UI展示提示
}

enum JIErrorCode: String {
    case noData = "-6000"
    case parseJSON = "-6001"
    case noHandler = "-6002"
    case noParameters = "-6003"
    case network = "-6004"
    case timeout = "-6005"
    case login = "-6006"
    case custom = "-7000"
    case tokenExpired = "401"

}

public enum JIError:Error,JIErrorAnalysable {
    /// 网络异常
    case network(code: String, message: String?)
    /// 后台异常
    case system(code: String, message: String?, data: Any?)
    /// 返回成功，但没有数据
    case noData
    /// 数据解析异常
    case parseJSON
    /// 超时
    case timeout
    /// token失效
    case tokenExpired
    /// 重登陆，请求回调里一般不需要处理，会发出重登录通知
    case login
    
    case noHandler
    case noParameters
    /// 自定义错误
    case custom(message: String)
    
    var code: String {
        switch self {
        case .network(let code, _):
            return code
        case .system(let code, _, _):
            return code
        case .noData:
            return JIErrorCode.noData.rawValue
        case .parseJSON:
            return JIErrorCode.parseJSON.rawValue
        case .noHandler:
            return JIErrorCode.noHandler.rawValue
        case .noParameters:
            return JIErrorCode.noParameters.rawValue
        case .timeout:
            return JIErrorCode.timeout.rawValue
        case .custom:
            return JIErrorCode.custom.rawValue
        case .tokenExpired:
            return JIErrorCode.tokenExpired.rawValue
        case .login:
            return JIErrorCode.login.rawValue
        }
    }
    
    var message: String {
        switch self {
        case .network(_, let message):
            return message ?? "网络异常"
        case .system( _, let message, _):
            return message ?? "系统异常"
        case .noData:
            return "没有数据"
        case .parseJSON:
            return "数据异常"
        case .noHandler:
            return "缺少响应"
        case .noParameters:
            return "缺少参数"
        case .timeout:
            return "超时"
        case .custom(let message):
            return message
        case .tokenExpired:
            return "token失效"
        case .login:  // 直接弹出登录页面，不需要toast提示
            return ""
        }
    }
    
    var toast: String {
        return message
    }
    
}

extension JIError: LocalizedError {
    public var errorDescription: String? {
        toast
    }
}

