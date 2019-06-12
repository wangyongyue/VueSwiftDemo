//
//  Field.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Field:MainProtocol{
    
    var arrayVue: Vue = Vue()
    var indexVue: Vue = Vue()
    
    func startListen() {
        
        
        loadData()
        
        indexVue.v_index { (index) in
            
            let m = self.arrayVue.v_array?[index] as! MainModel
            print(m.data?.name)
            print(m.v_identifier)
            if m.v_identifier == 0{
                
                //                Router.push(Details().getViewController(), ["id":"10"], nil)
                
            }
            
        }
        
    }
    
    static func getViewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = Field()
        vc.navigationItem.title = "field"
        return vc
        
    }
    
    func loadData(){
        
        var array = Array<VueData>()
        for i in 1...12{
            let m = FieldModel()
            let d = FieldData()
            m.data = d
            array.append(m)
            
        }
        
        arrayVue.v_array(true, v: { () -> Array<VueData>? in
            
            return array
        })
        
        
        
    }
    
    
}
class FieldModel: VueData,FieldCellProtocol{
    
    
    var v_palm: String = "FieldCell"
    var v_identifier:Int = 0
    var v_selectVue:Vue = Vue()
    
    
    var inputVue:Vue = Vue()
    var data:FieldData?
    
    func startListen() {
        inputVue.v_input {[weak self] in
            
            self?.data?.name = self?.inputVue.v_text
        }
    
        
    }
    
}
class FieldData{
    
    var name:String?
    
    
}
