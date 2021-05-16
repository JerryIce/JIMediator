//
//  File.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation

//MARK: - Request Protocol定义
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


