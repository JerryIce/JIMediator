//
//  JIReqProtocol.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation
import URLNavigator

//MARK: - 对象遵守这个协议就可以作为功能块的入口
//调request直接跳进新的功能块（可能是新控制器，也可能是新操作（网路请求等））
public protocol JIReqProtocol: AnyObject {
    associatedtype P
    associatedtype R
    var handler: ((_ parameters: P) -> Result<R, JIError>)? { get set }
    
    func handle(_ block: @escaping (_ parameters: P) -> Result<R, JIError>)
    func request(_ parameters: P, responseQueue: DispatchQueue, complete: ((Result<R, JIError>) -> ())?)
}

public extension JIReqProtocol {
    func handle(_ block: @escaping (_ parameters: P) -> Result<R, JIError>) {
        self.handler = block
    }
    
    func request(_ parameters: P, responseQueue: DispatchQueue = .main, complete: ((Result<R, JIError>) -> ())?) {
        
        if let handler = self.handler {
            let result = handler(parameters)
            responseQueue.async {
                complete?(result)
            }
        } else {
            responseQueue.async {
                complete?(Result.failure(.noHandler))
            }
        }
    }
}

//MARK:- 对象遵守这个协议就可以作为路由体系里的新VC
//registerCallback里是返回自己VC，全局的JIMediatorManager.shared.navigator（URLNavigator库）会管理VC的push和present

protocol JINavigationMapProtocol:JISelfAware{
    static var routePath: String {get}//自己的路由url
    static func registerCallback(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController?//自己的VC创建方法，返回VC
}

//如果是VC类，则有awake函数去把VC注册到全局navigator上
extension JINavigationMapProtocol where Self: UIViewController {
    static func awake() {
        JIMediatorManager.shared.navigator.register(routePath) { (url, values, context) -> UIViewController? in
            if url.queryParameters.count > 0 {
                guard let newUrl = url.urlValue else {
                    return registerCallback(url: url, values: values, context: context)
                }
                
                let newUrlStr = (newUrl.scheme ?? "") + "://" + (newUrl.host ?? "") + newUrl.path
                return registerCallback(url: newUrlStr, values: url.queryParameters, context: context)
            }else{
                return registerCallback(url: url, values: values, context: context)
            }
        }
    }
}


