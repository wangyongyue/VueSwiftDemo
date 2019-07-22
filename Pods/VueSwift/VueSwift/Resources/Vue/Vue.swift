//
//  Vue.swift
//  VueSwift
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
public typealias VueBlock = () -> ()
open class Vue :NSObject{
    
    public static var vueComponents = [String:String]()
    public static func register(aClass:AnyClass,toClass:AnyClass){
        let str = NSStringFromClass(aClass)
        let toStr = NSStringFromClass(toClass)
        vueComponents[str] = toStr
    }
    
    //text
    public typealias VueTextBlock = (String) -> ()
    public var blockTextDic = [String:VueTextBlock]()
    public func v_text(vId:String?,v:@escaping ()->String?){
        if let a = vId,let text = v(){
            blockTextDic[a]?(text)
        }
 
    }
    public func v_text(vId:String?,v:VueTextBlock?){
        if let a = vId,let b = v{
            blockTextDic[a] = b
        }
    }
    //attributedText
    public typealias VueAttributedTextBlock = (NSAttributedString) -> ()
    public var blockAttributedTextDic = [String:VueAttributedTextBlock]()
    public func v_attributedText(vId:String?,v:@escaping ()->NSAttributedString?){
        if let a = vId,let att = v(){
            blockAttributedTextDic[a]?(att)
        }
    }
    public func v_attributedText(vId:String?,v:VueAttributedTextBlock?){
        if let a = vId,let b = v{
            blockAttributedTextDic[a] = b
        }
    }
    
    //image
    public typealias VueImgBlock = (UIImage) -> ()
    public var blockImgDic = [String:VueImgBlock]()
    public func v_image(vId:String?,v:@escaping ()->UIImage?){
        if let a = vId,let img = v(){
            blockImgDic[a]?(img)
        }
    }
    public func v_image(vId:String?,v:VueImgBlock?){
        if let a = vId,let b = v{
            blockImgDic[a] = b
        }

    }
    
    //if
    public typealias VueIfBlock = (Bool) -> ()
    public var blockIfDic = [String:VueIfBlock]()
    public func v_if(vId:String?,v:@escaping ()->Bool?){
        if let a = vId,let isF = v(){
            blockIfDic[a]?(isF)
        }
    }
    public func v_if(vId:String?,v:VueIfBlock?){
        if let a = vId,let b = v{
            blockIfDic[a] = b
        }
    }
    
    //on
    public typealias VueOnBlock = () -> ()
    public var blockOnDic = [String:VueOnBlock]()
    public func v_on(vId:String?,v:VueOnBlock?){
        if let a = vId,let b = v{
            blockOnDic[a] = b
        }
    }
    public func v_on(vId:String?){
        if let a = vId {
            blockOnDic[a]?()
        }
    }
    
    //input
    public typealias VueInputBlock = () -> ()
    public var blockInputDic = [String:VueInputBlock]()
    public func v_input(vId:String?,v:VueInputBlock?){
        if let a = vId,let b = v{
            blockInputDic[a] = b
        }
    }
    public func v_input(vId:String?){
        if let a = vId {
            blockInputDic[a]?()
        }
    }
    
    //index
    public typealias VueIndexBlock = (Int) -> ()
    public var blockIndexDic = [String:VueIndexBlock]()
    public func v_index(vId:String?,v:VueIndexBlock?){
        if let a = vId,let b = v{
            blockIndexDic[a] = b
        }
    }
    public func v_index(vId:String?,index:Int){
        if let a = vId {
            blockIndexDic[a]?(index)
        }
    }

    
    //array
    public typealias VueArrayBlock = (Array<VueData>) -> ()
    public var blockArrayDic = [String:VueArrayBlock]()
    public func v_array(vId:String?,v:@escaping ()->Array<VueData>?){
        if let a = vId,let array = v(){
            blockArrayDic[a]?(array)
        }
    }
    public func v_array(vId:String?,v:VueArrayBlock?){
        if let a = vId,let b = v{
            blockArrayDic[a] = b
        }
    }
    
    //
    open func v_start(){}
    
}
