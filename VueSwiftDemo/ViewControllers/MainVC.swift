//
//  MainVC.swift
//  VueSwift
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019 wyy. All rights reserved.
//

import UIKit
import VueSwift
import SnapKit
class MainVC: UIViewController {

    
    var m:MainProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        let table = CTable()
        table.rowHeight = 60
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            
        }
        table.register([MainCell.classForCoder(),
                        TextCell.classForCoder(),
                        FieldCell.classForCoder(),
                        ButtonCell.classForCoder()
                        ])
        
        if let v = m?.arrayVue{
            table.v_array(vue: v)

        }
        
        if let v = m?.indexVue{
            table.v_index(vue: v)
        }
        
        m?.startListen()
    }

}
protocol MainProtocol {
    
    var arrayVue:Vue{get}
    var indexVue:Vue{get}
    func startListen()

}


class Screen{
    
    static func width() -> CGFloat{
        
        return UIScreen.main.bounds.width
    }
    static func height() -> CGFloat{
        
        return UIScreen.main.bounds.height
    }
}
