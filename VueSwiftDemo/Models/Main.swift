//
//  Main.swift
//  VueSwift
//
//  Created by apple on 2019/5/30.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Main:MainProtocol{
    
    var arrayVue: Vue = Vue()
    var indexVue: Vue = Vue()
    
    func startListen() {
        
        
        loadData()
        
        indexVue.v_index { (index) in
         
            
            switch index{
            case 0:Router.push(Text.getViewController(), ["id":"10"], nil)
            case 1:Router.push(Button.getViewController(), ["id":"10"], nil)
            case 2:Router.push(Field.getViewController(), ["id":"10"], nil)
            default:print("kong")
            }
           

            
        }
        
    }
    
    static func getViewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = Main()
        vc.navigationItem.title = "列表"
        return vc
        
    }
    
    func loadData(){
        
        let list = ["lable 使用","button 使用","textField 使用"]
        var array = Array<VueData>()
        for value in list{
            
            let m = MainModel()
            let d = MainData()
            d.name = value
            m.data = d
            array.append(m)
            
        }
        
        arrayVue.v_array(true, v: { () -> Array<VueData>? in
            
            return array
        })
        
        
        
    }
    
    
}
class MainModel: VueData,MainCellProtocol{
    
    
    var v_palm: String = "MainCell"
    var v_identifier:Int = 0
    var v_selectVue:Vue = Vue()
    
    
    var textVue:Vue = Vue()
    var clickVue:Vue = Vue()
    var tapVue:Vue = Vue()
    var data:MainData?
    
    func startListen() {
        
        textVue.v_text { () -> String? in
            
            return data?.name
        }
      
        tapVue.v_on {
            self.v_identifier = 0
            self.v_selectVue.v_on?()
        }
        
    }
    
}
class MainData{
    
    var name:String?
    
    
}
