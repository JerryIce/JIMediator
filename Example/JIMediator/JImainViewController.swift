//
//  ViewController.swift
//  JIMediator
//
//  Created by Jerry on 05/16/2021.
//  Copyright (c) 2021 Jerry. All rights reserved.
//

import UIKit
import JIMediator

class JImainViewController: UIViewController,JISelfAware{
    
    
    static let mediator = JIMediatorManager.shared
    
    static func awake() {
        // 静默自动登录
        mediator.autoLogin.handle { (param) -> Result<Void, JIError> in
            
            let random = arc4random() % 3
            
            switch random{
            case 0:
                return Result.failure(JIError.login)
            case 1:
                let result: Result<Void, JIError> = Result.failure(.noData)
                return result
            case 2:
                let result = Result<(), JIError>.success(())
                return result
            default:
                return Result.failure(JIError.timeout)
            }
        }
        
        //登出
        mediator.logout.handle { (param) -> Result<(), JIError> in
            var result: Result<Void, JIError> = Result.failure(.noData)
            //do something
            if arc4random() % 2 == 1{
                result = Result.success(())
            }
            return result
        }
        
        // 进入登录VC
        mediator.presentLogin.handle { (param) -> Result<(), JIError> in
            
            DispatchQueue.main.async {
                
                print("登录VC，清理缓存的用户信息")
                let fromVC = param.fromVC
                let loginVC = UIViewController()
                loginVC.self.view.backgroundColor = .green
                loginVC.modalPresentationStyle = .fullScreen
                fromVC.present(loginVC, animated: param.animated, completion: nil)
            }
            return Result.success(())
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func touchAutoLogin(_ sender: Any) {
        
        JImainViewController.mediator.autoLogin.request(JIAutoLogin.ReqParam()) { result in
            switch result{
            case .success():
                print("autoLogin_Success")
            case .failure(.login):
                print("autoLogin_Fail_alreadyLogin")
            case .failure(.noData):
                print("autoLogin_Fail_noData")
            case .failure(.timeout):
                print("autoLogin_Fail_timeOut")
            default:
                print("autoLogin_Fail")
            }
        }
        
    }
    
    @IBAction func touchLogout(_ sender: Any) {
        JImainViewController.mediator.logout.request(JILogout.ReqParam()) { result in
            switch result{
            case .success():
                print("Logout_Success")
            case .failure(.noData):
                print("Logout_Fail_noData")
            default:
                print("Logout_Fail")
            }
        }
    }
    
    @IBAction func touchPresentLoginVC(_ sender: Any) {
        JImainViewController.mediator.presentLogin.request(JIPresentLogin.ReqParam(fromVC: self, animated: true), responseQueue: DispatchQueue.main) { result in
            
        }
    }
    
    @IBAction func touchHomePage(_ sender: Any) {
        let str = JIInformationRouteMap.homePage.rawValue.appending("?id=123")
        JImainViewController.mediator.navigator.push(str)
    }
    
  
    @IBAction func touchInfoPage(_ sender: Any) {
        JImainViewController.mediator.navigator.push(JIInformationRouteMap.infomationHome.rawValue)
    }
    
    @IBAction func touchActivePage(_ sender: Any) {
        JImainViewController.mediator.navigator.present(JIInformationRouteMap.activityHome.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


