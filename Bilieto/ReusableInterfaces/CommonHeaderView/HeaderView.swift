//
//  HeaderView.swift
//  9-MAG
//
//  Created by PC on 1/22/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit


protocol HeaderViewDelegate {
    
    func onMoreBtnTap(sender : UIButton)
    func ClickToCodeScan(sender : UIButton)
    
    
   
}

class HeaderView: UIView {
    
     var delegate:HeaderViewDelegate?

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var codescanBtn: UIButton!
    @IBOutlet weak var notificationLbl: UILabel!
    
    @IBOutlet weak var constaintHeightTopView: NSLayoutConstraint!
    
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
    func initialize()  {
        
    }
    
    @IBAction func onMoreBtnTap(_ sender: UIButton) {
        delegate?.onMoreBtnTap(sender: sender)
    }
    @IBAction func ClickToCodeScan(_ sender: UIButton) {
        delegate?.ClickToCodeScan(sender: sender)
    }
    
}

class temVC: UIViewController {
    
}
   
    

