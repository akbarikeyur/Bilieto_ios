//
//  ForgotPasswordVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: - BUTTON CLICK
    @IBAction func ClickToSendLink(_ sender: Any) {
      
    }
    
    @IBAction func ClickToBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
