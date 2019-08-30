//
//  Main.swift
//  VueSwift
//
//  Created by apple on 2019/5/30.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Main:Vue,V_ViewControllerProtocol{
    
    func v_viewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = self
        vc.navigationItem.title = "列表"
        return vc
    }
    override func v_start() {
        
        let list = ["lable 使用","button 使用","textField 使用","test"]
        var array = Array<VueData>()
        for value in list{
            
            let m = MainModel()
            m.name = value
            array.append(m)
            
        }
        self.v_array(vId: arrayId) { () -> Array<VueData>? in
            
            return array
        }
        self.v_index(vId: indexId) { (index) in
            switch index{
            case 0:Router.push(Text(), ["id":10], nil)
            case 1:Router.push(Button(), ["id":10], nil)
            case 2:Router.push(Field(), ["id":10], nil)
            case 3:Router.push(Test(), ["id":10], nil)
            default:print("kong")
            }
        }
        
    }
    
    
}

