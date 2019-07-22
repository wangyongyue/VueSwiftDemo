//
//  CCollection.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

open class CCollection: UICollectionView ,UICollectionViewDelegate,UICollectionViewDataSource{

    public static var templates = Array<AnyClass>()
    public var array:Array<VueData>?
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        
       
        for (key,value) in Vue.vueComponents{
            let aClass = NSClassFromString(value)
            let superClass = class_getSuperclass(aClass)
            if let sClass = superClass{
                if NSStringFromClass(sClass) == NSStringFromClass(UICollectionViewCell.classForCoder()){
                    self.register(aClass, forCellWithReuseIdentifier: value)
                }
            }            
        }
        
    }
   
   public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = array?.count{
            return count
        }
        return 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = array?[indexPath.row]
        if let m = model{
            let identifier = Vue.vueComponents[NSStringFromClass(m.classForCoder)]
            if let ide =  identifier {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier!, for: indexPath)
                cell.setV_Model(m)
                m.v_to {
                    self.block?(indexPath.row)
                    self.vue?.v_index(vId: self.vId, index: indexPath.row)
                }
                
                return cell
            }
            
        }
        return UICollectionViewCell()
        
    }
    
   
    
    //v-array
    public func v_array(vId:String?,vue:Vue?){
        vue?.v_array(vId: vId) { (array) in
            self.array = array
            self.reloadData()
        }
    }
    
    
    //v_didSelect
    public typealias selectBlock = (_ index:Int) -> ()
    public var block:selectBlock?
    public func v_didSelect(vue:@escaping selectBlock){
        
        block = vue
        
    }
    
    
    //v-index
    public var vue:Vue?
    public var vId:String?
    public func v_index(vId:String?,vue:Vue?){
        self.vId = vId
        self.vue = vue
        
    }


}
extension UICollectionViewCell{
   @objc open func setV_Model(_ aModel:VueData){}
}
