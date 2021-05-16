//
//  JIFunctionModule.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation
import JIMediator

//MARK: - 主工程模块
//可扩展添加更多业务模块，只要遵守JIReqProtocol协议，实现handler（具体业务代码），ReqParam（实现业务代码需要的参数），之后外部调用业务模块的request并传入ReqParam，就会自动执行handler

//MARK: 登录注册模块
/// 进登录流程
class JIPresentLogin: JIReqProtocol {
    struct ReqParam {
        let fromVC: UIViewController
        let animated: Bool
        init(fromVC: UIViewController, animated: Bool) {
            self.fromVC = fromVC
            self.animated = animated
        }
    }
    var handler: ((ReqParam) -> Result<Void, JIError>)?
}

/// 自动登录
class JIAutoLogin: JIReqProtocol {
    struct ReqParam {
       init() {}
    }
    var handler: ((ReqParam) -> Result<Void, JIError>)?
}

/// 退出登录
class JILogout: JIReqProtocol {
    struct ReqParam {
       init() {}
    }
    var handler: ((ReqParam) -> Result<Void, JIError>)?
}
