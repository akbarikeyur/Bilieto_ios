//
//  ChangePasswordVC.swift
//  Bilieto
//
//  Created by pc1 on 02/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var oldPassTxt: TextField!
    @IBOutlet weak var newPassTxt: TextField!
    @IBOutlet weak var confirmPassTxt: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
    }
    
    @IBAction func ClickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        if oldPassTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_old_password", comment: ""))
        }
        else if newPassTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_new_password", comment: ""))
        }
        else if oldPassTxt.text == newPassTxt.text  {
            displayToast(NSLocalizedString("old_password_and_new_password_must_not_be_same", comment: ""))
        }
        else if confirmPassTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_confirm_password", comment: ""))
        }
        else if newPassTxt.text != confirmPassTxt.text  {
            displayToast(NSLocalizedString("new_password_and_confirm_password_must_be_same", comment: ""))
        }
        else {
            
            LoginSignupService.shared.serviceCallToChangePassword(oldPassTxt.text!, confirmPassTxt.text!, {
                 AppDelegate().sharedDelegate().navigateToDashboard()
            })
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == oldPassTxt
        {
            newPassTxt.becomeFirstResponder()
        }
        else if textField == newPassTxt
        {
            confirmPassTxt.becomeFirstResponder()
        }
        else if textField == confirmPassTxt
        {
            confirmPassTxt.resignFirstResponder()
        }
        return true
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is ChangePasswordVC) {
            let dict : [String : Int] = noti.object as! [String : Int]
            if let index : Int = dict["index"]
            {
                if index == 0
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 1
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangeStyleVC") as! ChangeStyleVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 2
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "OptionsVC") as! OptionsVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 3
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else {
                    AppDelegate().sharedDelegate().logout()
                }
            }
        }
    }
    
    
    @objc func redirectToScanQRCode(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is ChangePasswordVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
