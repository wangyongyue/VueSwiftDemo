//
//  TestCell.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class TestCell: UITableViewCell {
    
    
    let label:UILabel = {
        let a = UILabel()
        a.textColor = UIColor.black
        a.textAlignment = .center
        return a
    }()
    let tap = UITapGestureRecognizer()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(label)
        self.contentView.addGestureRecognizer(tap)
        label.text = "test"
        label.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func setV_Model(_ aModel: VueData) {
        if aModel is TestCellModel{
            
            let h = aModel as! TestCellModel
            label.text = h.name
            tap.v_tap {
                
                h.v_to()
            }
        }
    }
    
    
}


class TestCellModel: VueData{
    
    var name:String?
    override func v_height() -> CGFloat {
        
        return 100
    }
    init(_ a:String) {
        
        self.name = a
    }
}


