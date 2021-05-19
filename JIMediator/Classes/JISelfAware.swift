//
//  JISelfAware.swift
//  JIMediator
//
//  Created by 杨宗维 on 2021/5/16.
//

import Foundation

public protocol JISelfAware: AnyObject {
    static func awake()
//    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

//extension JISelfAware {
//
//    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
//        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
//        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
//        guard (originalMethod != nil && swizzledMethod != nil) else {
//            return
//        }
//        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
//            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
//        } else {
//            method_exchangeImplementations(originalMethod!, swizzledMethod!)
//        }
//    }
//}

public class NothingToSeeHere {
    public static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? JISelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}

//public extension UIApplication {
//    private static let runOnce: Void = {
//        NothingToSeeHere.harmlessFunction()
//    }()
//    override open var next: UIResponder? {
//        UIApplication.runOnce
//        return super.next
//    }
//}

//MARK: - ViewController
// 获取最上层控制器
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

