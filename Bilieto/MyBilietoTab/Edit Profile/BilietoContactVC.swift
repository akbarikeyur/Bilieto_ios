//
//  BilietoContactVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class BilietoContactVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phoneTxt: TextField!
    @IBOutlet weak var skypeTxt: TextField!
    @IBOutlet weak var cityTxt: TextField!
    @IBOutlet weak var stateTxt: TextField!
    @IBOutlet weak var zipcodeTxt: TextField!
    @IBOutlet weak var countryTxt: TextField!
    @IBOutlet weak var addressTxt: TextField!
    @IBOutlet weak var blogTxt: TextField!
    @IBOutlet weak var websiteTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        if phoneTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_phone", comment: ""))
        }
        else if skypeTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_skype_address", comment: ""))
        }
        else if cityTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_city", comment: ""))
        }
        else if stateTxt.text?.trimmed.isValidEmail == false
        {
            displayToast(NSLocalizedString("enter_state", comment: ""))
        }
        else  if zipcodeTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_zipcode", comment: ""))
        }
        else  if countryTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_country", comment: ""))
        }
        else  if addressTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_address", comment: ""))
        }
        else  if blogTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_blog", comment: ""))
        }
        else  if websiteTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_website", comment: ""))
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
        let vc : EditProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func ClickToAbout(_ sender: Any) {
        let vc : BilietoAboutVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoAboutVC") as! BilietoAboutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func ClickToSocial(_ sender: Any) {
        let vc : BilietoSocialVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoSocialVC") as! BilietoSocialVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
   
    //MARK: - TEXTFIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == phoneTxt
        {
            skypeTxt.becomeFirstResponder()
        }
        else if textField == skypeTxt
        {
            cityTxt.becomeFirstResponder()
        }
        else if textField == cityTxt
        {
            stateTxt.becomeFirstResponder()
        }
        else if textField == stateTxt
        {
            zipcodeTxt.becomeFirstResponder()
        }
        else if textField == zipcodeTxt
        {
            countryTxt.becomeFirstResponder()
        }
        else if textField == countryTxt
        {
            addressTxt.becomeFirstResponder()
        }
        else if textField == addressTxt
        {
            blogTxt.becomeFirstResponder()
        }
        else if textField == blogTxt
        {
            websiteTxt.becomeFirstResponder()
        }
        else if textField == websiteTxt
        {
            clickToSubmit(self)
        }
        return true
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is BilietoContactVC) {
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
        if (vc is BilietoContactVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
