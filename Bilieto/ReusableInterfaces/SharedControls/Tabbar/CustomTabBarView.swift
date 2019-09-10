//
//  CustomTabBarView.swift
//  Event Project
//
//  Created by ToShare Pty. Ltd on 20/07/17.
//  Copyright © 2017 ToShare Pty. Ltd. All rights reserved.
//

import UIKit

protocol CustomTabBarViewDelegate
{
    func tabSelectedAtIndex(index:Int)
}

class CustomTabBarView: UIView {

    @IBOutlet var btn1: Button!
    @IBOutlet var btn2: Button!
    @IBOutlet var btn3: Button!
    @IBOutlet var btn4: Button!
    @IBOutlet var btn5: Button!
    @IBOutlet weak var chatLbl: UILabel!
    @IBOutlet weak var notificationLbl: Label!
    
    var delegate:CustomTabBarViewDelegate?
    var lastIndex : NSInteger!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
       
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize()
    {
        lastIndex = 0

    }
    
    @IBAction func tabBtnClicked(_ sender: Any) {
        let btn: Button = sender as! Button
        lastIndex = btn.tag - 1

        resetAllButton()
        switch lastIndex {
        case 0:
            btn1.isSelected = true
            break
        case 1:
            btn2.isSelected = true
            break
        case 2:
            btn3.isSelected = true
            break
        case 3:
            btn4.isSelected = true
            break
        case 4:
            btn5.isSelected = true
            
            break
        default:
            break
        
        }
        
        delegate?.tabSelectedAtIndex(index: lastIndex)
    }

    func resetAllButton()
    {
        btn1.isSelected = false
        btn2.isSelected = false
        btn3.isSelected = false
        btn4.isSelected = false
        btn5.isSelected = false
    }
    
   
}
