//
//  TestViewController.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
import SnapKit

let testArrayId = "testArrayId"
let testIndexId = "testIndexId"
let testTextId = "testTextId"
let testImageId = "testImageId"
let testIfId = "testIfId"
let testOnId = "testOnId"
let testInputId = "testInputId"

class TestViewController: UIViewController {
    
    var m:Vue?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
       
        
        Vue.register(aClass: TestCellModel.classForCoder(), toClass:  TestCell.classForCoder())
        let table = CTable()
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            
        }
        
        
        
      
        let av = Vue()
        
        table.v_array(vId: testArrayId, vue: av)
        table.v_index(vId: testIndexId, vue: av)
        
       
        var array = Array<VueData>()
        for i in 1...12{
            let m = TestCellModel("test\(i)")
            array.append(m)
        }
        av.v_array(vId: testArrayId) { () -> Array<VueData>? in
            return array
        }
        
        av.v_index(vId: testIndexId) { (index) in
            
            print(index)
        }
        
        
//        m?.v_start()
    }
    
}

