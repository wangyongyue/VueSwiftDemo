//
//  CCollection.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit

public class CCollection: UICollectionView ,UICollectionViewDelegate,UICollectionViewDataSource{

    public static var templates = Array<AnyClass>()
    public var array:Array<VueData>?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        
        register(CCollection.templates)

        
    }
   
    required init?(coder aDecoder: NSCoder) {
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
        if let m = model,let palm = model?.v_palm{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: palm, for: indexPath)
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
        return UICollectionViewCell()
        
    }
    
    public func register(_ templates:Array<AnyClass>){

        for value in templates{
            let className:String=NSStringFromClass(value).components(separatedBy: ".").last!
            self.register(value, forCellWithReuseIdentifier: className)
        }
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
    

    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        block?(indexPath.row)
//
//        self.vue?.v_index?(indexPath.row)
//    }
    

}
