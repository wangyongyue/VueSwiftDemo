//
//  CTable.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

public class CTable: UITableView ,UITableViewDataSource,UITableViewDelegate{

    public static var templates = Array<AnyClass>()
    public var array:Array<VueData>?
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 50.0
        
        register(CTable.templates)

    }
    public override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = array?.count{
            return count
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = array?[indexPath.row]
        if let m = model ,let palm = model?.v_palm {
            let cell = self.dequeueReusableCell(withIdentifier: palm, for: indexPath)
            cell.selectionStyle = .none
            if cell is CellProtocol{
                let aCell = cell as! CellProtocol
                aCell.setModel(m)
            }
            
            m.v_selectVue.v_on {
                
                self.block?(indexPath.row)
                self.vue?.v_index?(indexPath.row)
            }
            return cell
        }
       
        return UITableViewCell()
        
    }
    
    public func register(_ templates:Array<AnyClass>){
        
        for value in templates{
            
            let className:String=NSStringFromClass(value).components(separatedBy: ".").last!
            self.register(value, forCellReuseIdentifier: className)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //v-array
    public func v_array(vue:Vue){
        
        vue.setupVue {
            self.array = vue.v_array
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
    public func v_index(vue:Vue){
        
        self.vue = vue
        
    }
   

}


