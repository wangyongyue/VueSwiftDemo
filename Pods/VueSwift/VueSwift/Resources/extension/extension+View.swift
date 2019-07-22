//
//  CView.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

open class VueData:NSObject {
    var v_identifier:Int = 0
    open func v_height() -> CGFloat{
        return 50
    }
    var v_block:VueBlock?
    func v_to(_ block:@escaping VueBlock){
        self.v_block = block
    }
    public func v_to(){
        self.v_block?()
    }
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


private var tapVueKey: UInt8 = 106
private var tapVueClickKey: UInt8 = 107
private var tapVIDKey: UInt8 = 108

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
    private var vId: String? {
        set {
            objc_setAssociatedObject(self, &tapVIDKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &tapVIDKey) as? String
        }
    }
    public func v_on(vId:String?,vue:Vue?){
        self.vId = vId
        self.vue = vue
        self.addTarget(self, action: #selector(tapEvent))
    }
    
    @objc func tapEvent(){
        self.block?()
        self.vue?.v_on(vId: self.vId)
        
    }
    
   
}
extension UIView{
    
    //v_if
    public func v_if(vId:String?,vue:Vue?){
        
        vue?.v_if(vId: vId) { (isf) in
            
            self.isHidden = isf
        }
       
        
    }
    
    
}
extension UILabel{
    
    //v_text
    public func v_text(vId:String?,vue:Vue?){
        vue?.v_text(vId: vId) { (text) in
            
            self.text = text
        }
    }
    //v_attributedText
    public func v_attributedText(vId:String?,vue:Vue?){
        vue?.v_attributedText(vId: vId) { (att) in
            
            self.attributedText = att
        }
       
    }

    
}

extension UIImageView{
    
    //v_image
    public func v_image(vId:String?,vue:Vue?){
        vue?.v_image(vId: vId) { (img) in
            self.image = img
        }
    }
    
}

private var buttonVueKey: UInt8 = 0
private var buttonVueClickKey: UInt8 = 1
private var BUTTONVIDKey: UInt8 = 30


extension UIButton{
    //v_text
    public func v_text(vId:String?,vue:Vue?){
        vue?.v_text(vId: vId) { (text) in
            self.setTitle(text, for: .normal)
        }
       
        
    }
    //v_image
    public func v_image(vId:String?,vue:Vue?){
        vue?.v_image(vId: vId) { (img) in
            self.setImage(img, for: .normal)
        }
    }

    //v_on
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &buttonVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &buttonVueKey) as? Vue
        }
    }
    private var vId: String? {
        set {
            objc_setAssociatedObject(self, &BUTTONVIDKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &BUTTONVIDKey) as? String
        }
    }
    
    public func v_on(vId:String?,vue:Vue?){
        
        self.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
        self.vue = vue
        self.vId = vId
        
    }
    @objc func clickEvent(){
        
        self.vue?.v_on(vId: self.vId)
        
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
private var textFieldVIDKey: UInt8 = 40

extension UITextField{
    
    //v_text
    public func v_text(vId:String?,vue:Vue?){
        vue?.v_text(vId: vId) { (text) in
            self.text = text
        }
        
    }
    
    //v_input
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &textFieldVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &textFieldVueKey) as? Vue
        }
    }
    private var vId: String? {
        set {
            objc_setAssociatedObject(self, &textFieldVIDKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &textFieldVIDKey) as? String
        }
    }
    public func v_input(vId:String?,vue:Vue?){
        self.vId = vId
        self.vue = vue
        self.addTarget(self, action: #selector(changeText), for: .editingChanged)
        
    }
    @objc func changeText(){
        
        self.vue?.v_text(vId: self.vId, v: { () -> String? in
            
            return self.text
        })
        self.vue?.v_input(vId: self.text)
        
    }
    
    //v_change
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
private var textVIDKey: UInt8 = 60

extension UITextView:UITextViewDelegate{
    
    //v_text
    public func v_text(vId:String?,vue:Vue?){
        vue?.v_text(vId: vId) { (text) in
            self.text = text
        }
      
    }
    
    //v_input
    private var vue: Vue? {
        set {
            objc_setAssociatedObject(self, &textVueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &textVueKey) as? Vue
        }
    }
    private var vId: String? {
        set {
            objc_setAssociatedObject(self, &textVIDKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, &textVIDKey) as? String
        }
    }
    
    public func v_input(vId:String?,vue:Vue?){
        self.vId = vId
        self.vue = vue
        self.delegate = self

    }

    
    public func textViewDidChange(_ textView: UITextView) {
        
        self.vue?.v_text(vId: self.vId, v: { () -> String? in
            
            return textView.text
        })
       self.vue?.v_input(vId: textView.text)
       block?()
        
    }
    
    //v_change
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
