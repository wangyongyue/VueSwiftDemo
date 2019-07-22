//
//  Button.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Button:Vue,V_ViewControllerProtocol{
    func v_viewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = self
        vc.navigationItem.title = "text"
        return vc
    }
    override func v_start() {
        
        let list = ["button1","button2","button3"]
        var array = Array<VueData>()
        for value in list{
            
            let m = ButtonModel()
            m.name = value
            array.append(m)
            
        }
        self.v_array(vId: arrayId) { () -> Array<VueData>? in
            
            return array
        }
    }
    
   
   
    
}
