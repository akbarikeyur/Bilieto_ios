//
//  EditProfileVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import DropDown

class EditProfileVC: UIViewController,UITextFieldDelegate ,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var firstnameTxt: TextField!
    @IBOutlet weak var middlenameTxt: TextField!
    @IBOutlet weak var lastnameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var professionTxt: TextField!
    @IBOutlet weak var dateTxt: TextField!
    @IBOutlet weak var yearTxt: TextField!
    @IBOutlet weak var monthTxt: TextField!
    @IBOutlet weak var hideDOBSwitch: UISwitch!
    @IBOutlet weak var hideYearSwitch: UISwitch!
    @IBOutlet weak var monthDropDownBtn: UIButton!
    @IBOutlet weak var profileBtnImg: Button!
    @IBOutlet weak var maleSwitch: UISwitch!
    @IBOutlet weak var femaleSwitch: UISwitch!
    let MonthBtnDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            
            self.MonthBtnDropDown
        ]
    }()
     var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
        profileBtnImg.layer.cornerRadius = 20
        profileBtnImg.layer.masksToBounds = true
        profileBtnImg.layer.borderWidth = 1
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        userDta()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
        tabBar.setTabBarHidden(tabBarHidden: false)
    }
    
    func userDta()  {
        firstnameTxt.text = AppModel.shared.currentUser.userFirstName
        middlenameTxt.text = AppModel.shared.currentUser.userMiddleName
        lastnameTxt.text = AppModel.shared.currentUser.userLastName
        professionTxt.text = AppModel.shared.currentUser.userProfession
        emailTxt.text = AppModel.shared.currentUser.userEmail
        
        if let date:Date = getDateFromString(AppModel.shared.currentUser.userBirthday, currFormat: DATE_FORMAT.SERVER_DATE){
            MonthBtnDropDown.selectRow(Int(getDateStringFromDate(date, format: "MM"))! - 1)
            monthTxt.text = MonthBtnDropDown.selectedItem!
            dateTxt.text = getDateStringFromDate(date, format: "dd")
            yearTxt.text = getDateStringFromDate(date, format: "yyyy")
        }
        
        
         if AppModel.shared.currentUser.userHideBday == "0" {
            hideDOBSwitch.isOn = false
         } else {
            hideDOBSwitch.isOn = true
         }
        
         if AppModel.shared.currentUser.userHideYear == "0" {
            hideYearSwitch.isOn = false
         } else {
            hideYearSwitch.isOn = true
         }
        
         if AppModel.shared.currentUser.userGender == "1" {
            maleSwitch.isOn = true
            femaleSwitch.isOn = false
         } else {
            femaleSwitch.isOn = true
             maleSwitch.isOn = false
         }
        
        if AppModel.shared.currentUser.userPhoto != nil {
        let str = API.IMAGE_PROFILE+"\(AppModel.shared.currentUser.userUniqueName!)"+"/profile/"+"\(AppModel.shared.currentUser.userPhoto!)"
        let url = URL(string: str)
            profileBtnImg.sd_setBackgroundImage(with: url, for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
            if image != nil{
                self.profileBtnImg.setBackgroundImage(image, for: .normal)
            }
        })
        }
        
    }
    
    //MARK: - DROPDOWN SETUP
    func setupDropDowns() {
        setupRightBarDropDown()
    }
    
    func setupRightBarDropDown() {
        MonthBtnDropDown.anchorView = monthDropDownBtn
        MonthBtnDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        
       
        MonthBtnDropDown.dataSource = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "Sept",
            "October",
            "November",
            "December"
        ]
        
        MonthBtnDropDown.selectionAction = { [weak self] (index, item) in
            
            self?.monthTxt.text = self?.MonthBtnDropDown.dataSource[index]
        }
    }
    
    //MARK: - BUTTON ACTION
    @IBAction func ClickToMonth(_ sender: Any) {
         self.view.endEditing(true)
        MonthBtnDropDown.show()
    }
    
    @IBAction func ClickToHideDOB(_ sender: Any) {
         self.view.endEditing(true)
    }
    @IBAction func ClickToHideYear(_ sender: Any) {
         self.view.endEditing(true)
    }
    @IBAction func ClickToMale(_ sender: Any) {
        self.view.endEditing(true)
        if maleSwitch.isOn {
            femaleSwitch.isOn = false
        }
    }
    @IBAction func ClickToFemale(_ sender: Any) {
        self.view.endEditing(true)
        if femaleSwitch.isOn{
            maleSwitch.isOn = false
        }
    }
    @IBAction func ClickToChooseFile(_ sender: Any) {
        self.view.endEditing(true)
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileBtnImg.setBackgroundImage(info[UIImagePickerController.InfoKey.editedImage] as? UIImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
        profileBtnImg.setTitle(" ", for: .normal)
    }
    
    @IBAction func ClickToSave(_ sender: Any) {
        self.view.endEditing(true)
        if firstnameTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_first_name", comment: ""))
        }
        else if lastnameTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_last_name", comment: ""))
        }
        else if emailTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_email", comment: ""))
        }
        else if emailTxt.text?.trimmed.isValidEmail == false
        {
            displayToast(NSLocalizedString("invalid_email", comment: ""))
        }
        else  if monthTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("select_month", comment: ""))
        }
        else  if dateTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_date", comment: ""))
        }
        else  if yearTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_year", comment: ""))
        }
        else if (yearTxt.text?.count)! < CONSTANT.DOB_YEAR_CHAR
        {
            displayToast(String(format: NSLocalizedString("year_min_char", comment: ""), String(CONSTANT.DOB_YEAR_CHAR)))
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
    @IBAction func ClickToAbout(_ sender: Any) {
        let vc : BilietoAboutVC = self.storyboard?.instantiateViewController(withIdentifier: "BilietoAboutVC") as! BilietoAboutVC
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string == ""){
            return true
        }
        
        var maxLength:Int = 0
        var str:String = ""
        
        if (textField == firstnameTxt){
            maxLength = CONSTANT.MAX_FIRST_NAME_CHAR
            str = firstnameTxt.text!
        }
        else if (textField == middlenameTxt){
            maxLength = CONSTANT.MAX_MIDDLE_NAME_CHAR
            str = middlenameTxt.text!
        }
        else if (textField == lastnameTxt){
            maxLength = CONSTANT.MAX_LAST_NAME_CHAR
            str = lastnameTxt.text!
        }
        else if(textField == dateTxt){
            maxLength = CONSTANT.DOB_DATE_CHAR
            str = (dateTxt.attributedText?.string)!
        }
        else if(textField == yearTxt){
            maxLength = CONSTANT.DOB_YEAR_CHAR
            str = (yearTxt.attributedText?.string)!
        }
        else{
            return true
        }
        return str.count < maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == firstnameTxt
        {
            middlenameTxt.becomeFirstResponder()
        }
        else if textField == middlenameTxt
        {
            lastnameTxt.becomeFirstResponder()
        }
        else if textField == lastnameTxt
        {
            professionTxt.becomeFirstResponder()
        }
        else if textField == professionTxt
        {
            emailTxt.becomeFirstResponder()
        }
        else if textField == emailTxt
        {
            dateTxt.becomeFirstResponder()
        }
        else if textField == dateTxt
        {
            yearTxt.becomeFirstResponder()
        }
        else if textField == yearTxt
        {
           ClickToSave(self)
        }
       
        return true
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is EditProfileVC) {
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
        if (vc is EditProfileVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
