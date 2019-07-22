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


let arrayId = "arrayId"
let indexId = "indexId"

class MainVC: UIViewController {
    
    var m:Vue?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        Vue.register(aClass: MainModel.classForCoder(), toClass:  MainCell.classForCoder())
        Vue.register(aClass: TextModel.classForCoder(), toClass:  TextCell.classForCoder())
        Vue.register(aClass: ButtonModel.classForCoder(), toClass:  ButtonCell.classForCoder())
        Vue.register(aClass: FieldModel.classForCoder(), toClass:  FieldCell.classForCoder())

        let table = CTable()
        table.rowHeight = 60
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            
        }
      
        table.v_array(vId: arrayId, vue: m)
        table.v_index(vId: indexId, vue: m)
      
        m?.v_start()
    }

}


class Screen{
    
    static func width() -> CGFloat{
        
        return UIScreen.main.bounds.width
    }
    static func height() -> CGFloat{
        
        return UIScreen.main.bounds.height
    }
}
