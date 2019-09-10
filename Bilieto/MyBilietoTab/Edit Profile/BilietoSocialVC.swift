//
//  BilietoSocialVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class BilietoSocialVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var facebookTxt: TextField!
    @IBOutlet weak var instagramTxt: TextField!
    @IBOutlet weak var twitterTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
    }

    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        if facebookTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_facebook_account", comment: ""))
        }
        else if instagramTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_instagram_account", comment: ""))
        }
        else if twitterTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_twitter_account", comment: ""))
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
    
    @IBAction func ClickToContact(_ sender: Any) {
        let vc : BilietoContactVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoContactVC") as! BilietoContactVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: - TEXTFIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == facebookTxt
        {
            instagramTxt.becomeFirstResponder()
        }
        else if textField == instagramTxt
        {
            twitterTxt.becomeFirstResponder()
        }
        else if textField == twitterTxt
        {
            clickToSubmit(self)
        }
        
        return true
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is BilietoSocialVC) {
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
        if (vc is BilietoSocialVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
