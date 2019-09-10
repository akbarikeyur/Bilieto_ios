//
//  MyBoardTVC.swift
//  Bilieto
//
//  Created by pc1 on 23/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class MyBoardTVC: UITableViewCell {

    @IBOutlet var boardImgBtn: UIButton!
    @IBOutlet var boardNameLbl: Label!
    @IBOutlet var userNameLbl: Label!
    @IBOutlet var boardDiscriptionLbl: Label!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
