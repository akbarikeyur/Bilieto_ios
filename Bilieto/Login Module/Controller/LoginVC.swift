//
//  LoginVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK:- Button Action
    @IBAction func ClickToLogin(_ sender: Any) {
        self.view.endEditing(true)
         if emailTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_email", comment: ""))
        }
        else if emailTxt.text?.trimmed.isValidEmail == false
        {
            displayToast(NSLocalizedString("invalid_email", comment: ""))
        }
        else  if passwordTxt.text?.count == 0
        {
            displayToast(NSLocalizedString("enter_password", comment: ""))
        }
        else {

            AppModel.shared.currentUser = UserModel()
            AppModel.shared.currentUser.userEmail = self.emailTxt.text!.trimmed
            AppModel.shared.currentUser.userPassword = self.passwordTxt.text!.trimmed
            
            LoginSignupService.shared.serviceCallToLogin {
                AppDelegate().sharedDelegate().navigateToDashboard()
            }

        }
    }

    @IBAction func ClickToForgotPassword(_ sender: Any) {
        self.view.endEditing(true)
        let vc : ForgotPasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ClickToSignUp(_ sender: Any) {
        self.view.endEditing(true)
        let vc : SignUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        if textField == emailTxt
        {
            passwordTxt.becomeFirstResponder()
        }
        else if textField == passwordTxt
        {
            ClickToLogin(self)
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
