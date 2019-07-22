//
//  Button.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class ButtonCell: UITableViewCell {
    
    
   
    let leftButton:UIButton = {
        let a = UIButton()
        a.setTitle("left", for: .normal)
        a.setTitleColor(UIColor.red, for: .normal)
        return a
    }()
    let button:UIButton = {
        let a = UIButton()
        a.setTitle("right", for: .normal)
        a.setTitleColor(UIColor.red, for: .normal)
        return a
    }()
    let tap = UITapGestureRecognizer()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(leftButton)
        self.contentView.addSubview(button)
        self.contentView.addGestureRecognizer(tap)


        leftButton.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(12)
            make.width.equalTo(100)

        }
        button.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-12)
            make.width.equalTo(100)
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func setV_Model(_ aModel: VueData) {
        if aModel is ButtonModel{
            
            let h = aModel as! ButtonModel
            leftButton.v_click {
                
                h.v_to()
            }
            button.v_click {
                
                h.v_to()
            }
        }
    }
    
    
}

class ButtonModel: VueData{
    
    var name:String?
    
}
