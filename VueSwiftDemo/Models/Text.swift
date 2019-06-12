//
//  Text.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class Text:MainProtocol{
    
    var arrayVue: Vue = Vue()
    var indexVue: Vue = Vue()
    
    func startListen() {
        
        loadData()
        
        indexVue.v_index { (index) in
        
            
        }
        
    }
    
    static func getViewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = Text()
        vc.navigationItem.title = "text"
        return vc
        
    }
    
    func loadData(){
        
        let list = ["lable1","lable2","lable3"]
        var array = Array<VueData>()
        for value in list{
            
            let m = TextModel()
            let d = TextData()
            d.name = value
            m.data = d
            array.append(m)
            
        }
        
        arrayVue.v_array(true, v: { () -> Array<VueData>? in
            
            return array
        })
        
        
        
    }
    
    
}
class TextModel: VueData,TextCellProtocol{
    
    
    var v_palm: String = "TextCell"
    var v_identifier:Int = 0
    var v_selectVue:Vue = Vue()
    
    
    var textVue:Vue = Vue()
    var tapVue:Vue = Vue()
    var data:TextData?
    
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
class TextData{
    
    var name:String?
    
    
}
