//
//  TextCell.swift
//  VueSwiftDemo
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
class TextCell: UITableViewCell,CellProtocol {
    
    
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
    func setModel(_ amodel: VueData) {
        
        if amodel is TextCellProtocol{
            
            let h = amodel as! TextCellProtocol
            label.v_text(vue: h.textVue)
            tap.v_on(vue: h.tapVue)
            
            h.startListen()
        }
    }
    
    
}
protocol TextCellProtocol {
    
    var textVue:Vue{get}
    var tapVue:Vue{get}
    
    func startListen()
}


