//
//  Test.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Test:Vue,V_ViewControllerProtocol{
    
    func v_viewController() -> UIViewController {
        
        let vc = TestViewController()
        vc.m = self
        vc.navigationItem.title = "test"
        return vc
    }
    override func v_start() {
        
        
        self.v_text(vId: testIfId) { () -> String? in
            return "label"
        }
        
        var array = Array<VueData>()
        for i in 1...12{
            
            let m = TestCellModel("test\(i)")
            array.append(m)
            
        }
        self.v_array(vId: testArrayId) { () -> Array<VueData>? in
            
            return array
        }
        self.v_index(vId: testIndexId) { (index) in
           
            print(index)
        }
        
    }
    
    
}
