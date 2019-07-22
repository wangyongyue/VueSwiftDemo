//
//  FieldCell.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class FieldCell: UITableViewCell {
    
    
    let label:UILabel = {
        let a = UILabel()
        a.textColor = UIColor.black
        a.textAlignment = .center
        return a
    }()
    let field:UITextField = {
        let a = UITextField()
        a.borderStyle = .roundedRect
        a.textColor = UIColor.black
        a.placeholder = "请输入"
        a.keyboardType = .default
        a.returnKeyType = .done
        return a
    }()
    let tap = UITapGestureRecognizer()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(field)
        self.contentView.addGestureRecognizer(tap)

        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(12)
            make.width.equalTo(100)

        }
        field.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-12)
            make.width.equalTo(100)
            
        }
        field.v_change {[weak self] in
            
            self?.label.text = self?.field.text
        }
        tap.v_tap {[weak self] in
            
            self?.field.resignFirstResponder()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func setV_Model(_ aModel: VueData) {
        if aModel is FieldModel{
            
            let h = aModel as! FieldModel
            label.text = h.name
            
        }
    }
    
    
}

class FieldModel: VueData{
    
    var name:String?
    
}
