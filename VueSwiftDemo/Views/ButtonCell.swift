//
//  Button.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift

class ButtonCell: UITableViewCell,CellProtocol {
    
    
   
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
    func setModel(_ amodel: VueData) {
        
        if amodel is ButtonCellProtocol{
            
            let h = amodel as! ButtonCellProtocol
            leftButton.v_on(vue: h.leftClickVue)
            button.v_on(vue: h.clickVue)
            tap.v_on(vue: h.tapVue)
            
            h.startListen()
        }
    }
    
    
}
protocol ButtonCellProtocol {
    
    var leftClickVue:Vue{get}
    var clickVue:Vue{get}
    var tapVue:Vue{get}
    
    func startListen()
}


