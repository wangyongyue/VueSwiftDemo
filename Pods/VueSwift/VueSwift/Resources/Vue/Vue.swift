//
//  Vue.swift
//  VueSwift
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
public typealias VueBlock = () -> ()
public class Vue :NSObject{
    private var array = Array<VueBlock>()
    
    
    public var v_text:String?
    public func v_text(v:()->String?){
        
        v_text = v()
        sendVueMsg()
    }
    
    public var v_image:UIImage?
    public func v_image(v:()->UIImage?){
        
        v_image = v()
        sendVueMsg()
    }
    public var v_backgroundColor:UIColor?
    public func v_backgroundColor(v:()->UIColor?){
        
        v_backgroundColor = v()
        sendVueMsg()
    }
    
    public var v_if:Bool?
    public func v_if(v:()->Bool?){
        
        v_if = v()
        sendVueMsg()
    }
    
    public var v_selected:Bool?
    public func v_selected(v:()->Bool?){
        
        v_selected = v()
        sendVueMsg()
    }
    
    
    
    
    public var v_on:VueBlock?
    public func v_on(vue:@escaping VueBlock){
        
        self.v_on = vue
        
    }
    
    public var v_input:VueBlock?
    public func v_input(vue:@escaping VueBlock){
        
        self.v_input = vue
        
    }
    
    
    public typealias VueIndexBlock = (_ index:Int) -> ()
    public var v_index:VueIndexBlock?
    public func v_index(vue:@escaping VueIndexBlock){
        
        self.v_index = vue
        
    }
    
    
    public var v_array:Array<VueData>?
    public func v_array(_ isPage:Bool,v:()->Array<VueData>?){
        if isPage{
            if let arr = v(),let v_arr = v_array{
                
                v_array = v_arr + arr
            }else{
                v_array = v()
                
            }
            
        }else{
            
            v_array = v()
            
        }
        sendVueMsg()
    }
    
    
    
   public func setupVue(_ callBack:@escaping VueBlock){
        
        array.append(callBack)
        
    }
    public func sendVueMsg(){
        
        for value in array{
            
            value()
        }
    }
    
}
