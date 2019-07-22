//
//  Router.swift
//  HalfDay
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 wangyongyue. All rights reserved.
//

import UIKit

public protocol V_ViewControllerProtocol{
    func v_viewController() -> UIViewController
}

public class Router :NSObject {
    
    public class func v_params() -> [String:Any]?{
        
        if let dic = currentController().params{
            return dic
        }
        return nil
    }
    public class func push(_ m: V_ViewControllerProtocol,_ params:[String:Any]?,_ block:popCallBack?){
        
        let vc = m.v_viewController()
        vc.params = params
        vc.call = block
        navigationController()?.pushViewController(vc, animated: true)
    }
    
    public class func pop(_ objc:AnyObject?){
        
        if objc != nil{
            
            let currentVC = currentController()
            currentVC.call?(objc)
        }
        navigationController()?.popViewController(animated: true)
    }
    
    public class func popViewController(toIndex:Int,_ objc:AnyObject?){
        
        if let arr = navigationController()?.viewControllers{
            if arr.count > (toIndex + 1){
                
                let index = arr.count - toIndex - 1
                let vc = navigationController()?.viewControllers[index]
                let nextVC = navigationController()?.viewControllers[index+1]
                nextVC?.call?(objc)
                if let v = vc{
                    navigationController()?.popToViewController(v, animated: true)
                }
                
            }
            
        }
        
        
    }
    
    public class func navigationController() -> UINavigationController?{
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        
        if vc is UINavigationController{
            return vc as? UINavigationController
        }
        if vc is UITabBarController{
            
            let bar = vc as? UITabBarController
            
            if let index = bar?.selectedIndex{
                let currentVC = bar?.viewControllers?[index]
                if currentVC is UINavigationController{
                    return currentVC as? UINavigationController
                }
            }
            
        }
        
        return nil
    }
    
    public class func currentController() -> UIViewController{
        
        let controller = navigationController()
        
        if let vc = controller?.viewControllers.last{
            return vc
        }
        return UIViewController()
    }
    
   
    

}
