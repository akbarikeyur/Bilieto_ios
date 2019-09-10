//
//  BilietoAboutVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class BilietoAboutVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var aboutTxtView: TextView!
    @IBOutlet weak var statusTxt: TextField!
    @IBOutlet weak var placeTxt: TextField!
    @IBOutlet weak var schoolTxt: TextField!
    @IBOutlet weak var interestTxt: TextField!
    @IBOutlet weak var tagTxt: TextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
    }
    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        if aboutTxtView.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_about", comment: ""))
        }
        else if statusTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_status", comment: ""))
        }
        else if placeTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_place", comment: ""))
        }
        else if schoolTxt.text?.trimmed.isValidEmail == false
        {
            displayToast(NSLocalizedString("enter_school_name", comment: ""))
        }
        else  if interestTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_interest", comment: ""))
        }
        else  if tagTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_tag", comment: ""))
        }
        
        else {
//              LoginSignupService.shared.serviceCallToRegister {
//
//                showAlert("", message: NSLocalizedString("register_success", comment: ""),completion: {
//                    AppDelegate().sharedDelegate().navigateToDashboard()
//
//                })
//            }
        }
    
        
    }
    
    @IBAction func ClickToGeneral(_ sender: Any) {
        let vc  : EditProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func ClickToSocial(_ sender: Any) {
        let vc : BilietoSocialVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoSocialVC") as! BilietoSocialVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func ClickToContact(_ sender: Any) {
        let vc : BilietoContactVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoContactVC") as! BilietoContactVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: - TEXTFIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == aboutTxtView
        {
            statusTxt.becomeFirstResponder()
        }
        else if textField == statusTxt
        {
            placeTxt.becomeFirstResponder()
        }
        else if textField == placeTxt
        {
            schoolTxt.becomeFirstResponder()
        }
        else if textField == schoolTxt
        {
            interestTxt.becomeFirstResponder()
        }
        else if textField == interestTxt
        {
            tagTxt.becomeFirstResponder()
        }
        else if textField == tagTxt
        {
            clickToSubmit(self)
        }
        return true
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is BilietoAboutVC) {
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
        if (vc is BilietoAboutVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
