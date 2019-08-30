//
//  Text.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class Text:Vue,V_ViewControllerProtocol{
    
    func v_viewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = self
        vc.navigationItem.title = "text"
        return vc
    }
    override func v_start() {
        
        let list = ["lable1","lable2","lable3"]
        var array = Array<VueData>()
        for i in 1...120{
            
            let m = TextModel()
            m.name = "lable1"
            array.append(m)
            
        }
        self.v_array(vId: arrayId) { () -> Array<VueData>? in
            
            return array
        }
    }
    
    
}
