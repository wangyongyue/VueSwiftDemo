//
//  CView.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

public protocol VueData {
    
    var v_palm:String{get}
    var v_identifier:Int{get}
    var v_selectVue:Vue{get}
}

public protocol CellProtocol{
    
    func setModel(_ amodel:VueData)
    
}

private var vcMapKey: UInt8 = 8
private var vcBlockKey: UInt8 = 9
public typealias popCallBack = (_ obj:AnyObject?) -> ()

extension UIViewController{
   
    public var params:[String:Any]? {
        set {
            objc_setAssociatedObject(self, &vcMapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &vcMapKey) as? [String:Any]
        }
    }
    
    public var call: popCallBack? {
        set {
            objc_setAssociatedObject(self, &vcBlockKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &vcBlockKey) as? popCallBack
        }
    }

}


private var tapVueKey: UInt8 = 6
private var tapVueClickKey: UInt8 = 7
extension UITapGestureRecognizer{
    
    
    private var block: VueBlock? {
        set {
            objc_setAssociatedObject(self, &tapVueClickKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &tapVueClickKey) as? VueBlock
        }
    }
    
    public func v_tap(_ block:@escaping VueBlock){
        self.block = block
        self.addTarget(self, action: #selector(tapEvent))
    }
    
    
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &tapVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &tapVueKey) as? Vue
        }
    }
    public func v_on(vue:Vue){
        
        self.vue = vue
        self.addTarget(self, action: #selector(tapEvent))
    }
    
    @objc func tapEvent(){
        self.block?()
        self.vue?.v_on?()
        
    }
    
   
}
extension UIView{
    
    //v-backgroundColor
    public func v_backgroundColor(vue:Vue){
        vue.setupVue {

            self.backgroundColor = vue.v_backgroundColor
        }
        
    }
    //v-if
    public func v_if(vue:Vue){
        
        vue.setupVue {
            
            if let v = vue.v_if{
                self.isHidden = v
            }
        }
        
    }
    
    
}
extension UILabel{
    
    
    //{{ text }}
    public func v_text(vue:Vue){
        
        vue.setupVue {
            self.text = vue.v_text
        }
        
    }

    
}

extension UIImageView{
    
    //v-image
    public func v_image(vue:Vue){
        
        vue.setupVue {
            self.image = vue.v_image
        }
        
    }
    
    
    
}

private var buttonVueKey: UInt8 = 0
private var buttonVueClickKey: UInt8 = 1


extension UIButton{
    //{{ text }}
    public func v_text(vue:Vue){
        
        vue.setupVue {
            self.setTitle(vue.v_text, for: .normal)
        }
        
    }
    //v-image
    public func v_image(vue:Vue){
        
        vue.setupVue {
            self.setImage(vue.v_image, for: .normal)
        }
        
    }
   
    //v-selected
    public func v_selected(vue:Vue){
        
        vue.setupVue {
            if let v = vue.v_selected{
                
                self.isSelected = v

            }
        }
        
    }
    
    //v-on
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &buttonVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &buttonVueKey) as? Vue
        }
    }
    
    public func v_on(vue:Vue){
        
        self.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
        self.vue = vue
        
    }
    @objc func clickEvent(){
        
        self.vue?.v_on?()
        
    }
    
    //v-click
    private var block: VueBlock? {
        set {
            objc_setAssociatedObject(self, &buttonVueClickKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &buttonVueClickKey) as? VueBlock
        }
    }
    
    public func v_click(vue:@escaping VueBlock){
        
        self.addTarget(self, action: #selector(clickNewEvent), for: .touchUpInside)
        block = vue
        
    }
    @objc func clickNewEvent(){
        
        block?()
    }

    
}

private var textFieldVueKey: UInt8 = 2
private var textFieldClickKey: UInt8 = 3
extension UITextField{
    
    //{{ text }}
    public func v_text(vue:Vue){
        
        vue.setupVue {
            self.text = vue.v_text
        }
        
    }
    
    //v-input
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &textFieldVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &textFieldVueKey) as? Vue
        }
    }
    public func v_input(vue:Vue){
        
        self.vue = vue
        self.addTarget(self, action: #selector(changeText), for: .editingChanged)
        
    }
    @objc func changeText(){
        
        self.vue?.v_text(v: { () -> String? in
            
            return self.text
        })
        
        self.vue?.v_input?()
    }
    
    //v-change
    
    private var block: VueBlock? {
        set {
            objc_setAssociatedObject(self, &textFieldClickKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &textFieldClickKey) as? VueBlock
        }
    }
    
    public func v_change(vue:@escaping VueBlock){
        
        block = vue
        self.addTarget(self, action: #selector(changeNewText), for: .editingChanged)
        
    }
    @objc func changeNewText(){
        
        block?()
    }
    
}

private var textVueKey: UInt8 = 4
private var textClickKey: UInt8 = 5

extension UITextView:UITextViewDelegate{
    
    //{{ text }}
    public func v_text(vue:Vue){
        
        vue.setupVue {
            self.text = vue.v_text
        }
        
    }
    
    //v-input
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &textVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &textVueKey) as? Vue
        }
    }
    
    public func v_input(vue:Vue){
        
        self.vue = vue
        self.delegate = self

    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.vue?.v_text(v: { () -> String? in
            return self.text
        })
        
        block?()
        self.vue?.v_input?()
        
    }
    
    
    //v-change
    public typealias changeBlock = (_ text:String) ->()
    private var block: VueBlock? {
        set {
            objc_setAssociatedObject(self, &textFieldClickKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &textFieldClickKey) as? VueBlock
        }
    }
    public func v_change(vue:@escaping VueBlock){
        
        block = vue
        self.delegate = self
        
    }
    
    
}
