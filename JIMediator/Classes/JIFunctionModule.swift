//
//  JIFunctionModule.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation

//MARK: - JIReqProtocol功能模块
//可扩展添加更多业务模块，只要遵守JIReqProtocol协议，实现handler（具体业务代码），ReqParam（实现业务代码需要的参数），之后外部调用业务模块的request并传入ReqParam，就会自动执行handler

//例子
// 进登录流程
public class JIPresentLogin: JIReqProtocol {
    public struct ReqParam {
        public let fromVC: UIViewController
        public let animated: Bool
        public init(fromVC: UIViewController, animated: Bool) {
            self.fromVC = fromVC
            self.animated = animated
        }
    }
    public var handler: ((ReqParam) -> Result<Void, JIError>)?
}

// 自动登录
public class JIAutoLogin: JIReqProtocol {
    public struct ReqParam {
        public init() {}
    }
    public var handler: ((ReqParam) -> Result<Void, JIError>)?
}

//退出登录
public class JILogout: JIReqProtocol {
    public struct ReqParam {
        public init() {}
    }
    public var handler: ((ReqParam) -> Result<Void, JIError>)?
}



import UIKit
import URLNavigator
//MARK: - JINavigationMapProtocol功能模块
public enum JIInformationRouteMap: String {
    /// 资讯首页
    case homePage = "jivc://homePage"
    /// 信息首页
    case infomationHome = "jivc://information/home"
    /// 活动首页列表
    case activityHome = "jivc://activity/home"

}

class JIHomePageViewController:UIViewController, JINavigationMapProtocol {
    
    static var routePath: String {
        return JIInformationRouteMap.homePage.rawValue
    }
    
    static func registerCallback(url: URLConvertible, values: [String : Any], context: Any?) -> UIViewController? {
        if let `id` = values["id"] as? String {
            let vc = JIHomePageViewController()
            vc.homePara = id
            return vc
        }
        return nil
    }
    
    var homePara = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        print("获得参数：%@",self.homePara);
    }
    
}

class JIInfomationHomeViewController:UIViewController, JINavigationMapProtocol {
    
    static var routePath: String {
        return JIInformationRouteMap.infomationHome.rawValue
    }
    
    static func registerCallback(url: URLConvertible, values: [String : Any], context: Any?) -> UIViewController? {
        let vc = JIInfomationHomeViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
}

class JIActivityHomeViewController:UIViewController, JINavigationMapProtocol {
    
    static var routePath: String {
        return JIInformationRouteMap.activityHome.rawValue
    }
    
    static func registerCallback(url: URLConvertible, values: [String : Any], context: Any?) -> UIViewController? {
        
        let vc = JIActivityHomeViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
  
}
