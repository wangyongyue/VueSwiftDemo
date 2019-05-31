//
//  Button.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class Button:MainProtocol{
    
    var arrayVue: Vue = Vue()
    var indexVue: Vue = Vue()
    
    func startListen() {
        
        
        loadData()
        
        indexVue.v_index { (index) in
            
            
            let m = self.arrayVue.v_array?[index] as! ButtonModel
            
          
            var msg = "\(index)"
            if m.v_identifier == 0{
                msg = "left"
                
            }else if m.v_identifier == 1{
                
                msg = "right"

            }
            let alertController = UIAlertController(title: "提示",
                                                    message: msg, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            Router.currentController().present(alertController, animated: true, completion: nil)

        }
        
    }
    
    func getViewController() -> UIViewController {
        
        let vc = MainVC()
        vc.m = self
        vc.navigationItem.title = "button"
        return vc
        
    }
    
    func loadData(){
        
        var array = Array<VueData>()
        for i in 1...6{

            let m = ButtonModel()
            let d = ButtonData()
            m.data = d
            array.append(m)
            
        }
        
        arrayVue.v_array(true, v: { () -> Array<VueData>? in
            
            return array
        })
        
        
        
    }
    
    
}
class ButtonModel: VueData,ButtonCellProtocol{
    
    
    var v_palm: String = "ButtonCell"
    var v_identifier:Int = 0
    var v_selectVue:Vue = Vue()
    
    
    var leftClickVue:Vue = Vue()
    var clickVue:Vue = Vue()
    var tapVue:Vue = Vue()
    var data:ButtonData?
    
    func startListen() {
        
        leftClickVue.v_on {
            self.v_identifier = 0
            self.v_selectVue.v_on?()
        }
        clickVue.v_on {
            self.v_identifier = 1
            self.v_selectVue.v_on?()
        }
        tapVue.v_on {
            self.v_identifier = 2
            self.v_selectVue.v_on?()
        }
        
    }
    
}
class ButtonData{
    
    var name:String?
    
    
}
