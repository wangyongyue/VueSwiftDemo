//
//  FieldCell.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class FieldCell: UITableViewCell,CellProtocol {
    
    
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
            
        }
        field.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-12)
            make.width.equalTo(100)
            
        }
        tap.v_tap {[weak self] in
            
            self?.field.resignFirstResponder()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    func setModel(_ amodel: VueData) {
        
        if amodel is FieldCellProtocol{
            
            let h = amodel as! FieldCellProtocol
            label.v_text(vue: h.inputVue)
            field.v_input(vue: h.inputVue)
            
            h.startListen()
        }
    }
    
    
}
protocol FieldCellProtocol {
    
    var inputVue:Vue{get}
    
    func startListen()
}


