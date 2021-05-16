//
//  ViewController.swift
//  JIMediator
//
//  Created by Jerry on 05/16/2021.
//  Copyright (c) 2021 Jerry. All rights reserved.
//

import UIKit
import JIMediator

class JImainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configFunctions()
        
    }
    
    @IBAction func touchAutoLogin(_ sender: Any) {
        
        JIMediatorManager.shared.autoLogin.request(JIAutoLogin.ReqParam()) { result in
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
        JIMediatorManager.shared.logout.request(JILogout.ReqParam()) { result in
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
        JIMediatorManager.shared.presentLogin.request(JIPresentLogin.ReqParam(fromVC: self, animated: true), responseQueue: DispatchQueue.main) { result in
            
        }
    }
    
    
    func configFunctions() -> Void {
        let mediator = JIMediatorManager.shared
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





//MARK: - ViewController
/// 获取最上层控制器
public var TopViewController: UIViewController? {
    var topVC: UIViewController?
    topVC = _resultVC(VC: UIApplication.shared.windows.first?.rootViewController)
    return topVC
}

private func _resultVC(VC: UIViewController?) -> UIViewController? {
    var resultVC: UIViewController? = VC
    if VC?.isKind(of: UINavigationController.self) == true {
        resultVC = _resultVC(VC: (VC as! UINavigationController).topViewController)
    } else if VC?.isKind(of: UITabBarController.self) == true {
        resultVC = _resultVC(VC: (VC as! UITabBarController).selectedViewController)
    } else if VC?.presentedViewController != nil {
        resultVC = _resultVC(VC: VC?.presentedViewController)
    }
    return resultVC
}
