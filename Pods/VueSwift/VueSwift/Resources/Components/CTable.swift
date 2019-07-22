//
//  CTable.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

open class CTable: UITableView ,UITableViewDataSource,UITableViewDelegate{

    public var array:Array<VueData>?
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.tableFooterView = UIView()
        
        for (key,value) in Vue.vueComponents{
            let aClass = NSClassFromString(value)
            let superClass = class_getSuperclass(aClass)
            if let sClass = superClass{
                if NSStringFromClass(sClass) == NSStringFromClass(UITableViewCell.classForCoder()){
                    self.register(aClass, forCellReuseIdentifier: value)
                }
               
            }
            
            
        }

    }
    open override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = array?[indexPath.row]
        if let h = model?.v_height(){
            
            return h
        }
        return 50
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = array?.count{
            return count
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = array?[indexPath.row]
        if let m = model  {
            let identifier = Vue.vueComponents[NSStringFromClass(m.classForCoder)]
            if let ide =  identifier {
                let cell = tableView.dequeueReusableCell(withIdentifier: ide, for: indexPath)
                cell.selectionStyle = .none
                cell.setV_Model(m)
                m.v_to {
                    self.block?(indexPath.row)
                    self.vue?.v_index(vId: self.vId, index: indexPath.row)
                }

                return cell
            }
        }
       
        return UITableViewCell()
        
    }
    
   
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

extension UITableViewCell{
   @objc open func setV_Model(_ aModel:VueData){}
}
