//
//  SignUpVC.swift
//  Bilieto
//
//  Created by Amisha on 4/3/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import DropDown

class SignUpVC: UIViewController ,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var FirstnameTxt: TextField!
    @IBOutlet weak var middlenameTxt: TextField!
    @IBOutlet weak var lastnameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var professionTxt: TextField!
    @IBOutlet weak var monthTxt: TextField!
    @IBOutlet weak var datetxt: TextField!
    @IBOutlet weak var yearTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var resetPasswordTxt: TextField!
    @IBOutlet weak var profileBtnImg: Button!
    @IBOutlet weak var hideDOBSwitch: UISwitch!
    @IBOutlet weak var hideyearSwitch: UISwitch!
    @IBOutlet weak var maleSwitch: UISwitch!
    @IBOutlet weak var femaleSwitch: UISwitch!
    @IBOutlet weak var monthDropDownBtn: UIButton!
    
    var userImg : UIImage = UIImage()
    
    let MonthBtnDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.MonthBtnDropDown
        ]
    }()
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        femaleSwitch.isOn = false
       
        profileBtnImg.layer.cornerRadius = 20
        profileBtnImg.layer.masksToBounds = true
        profileBtnImg.layer.borderWidth = 1
        
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
    }
    
    //MARK: - DROPDOWN SETUP
    func setupDropDowns() {
        setupRightBarDropDown()
    }
    
    func setupRightBarDropDown() {
        MonthBtnDropDown.anchorView = monthDropDownBtn
        MonthBtnDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        MonthBtnDropDown.dataSource = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ]
        
        MonthBtnDropDown.selectionAction = { [weak self] (index, item) in
          
            self?.monthTxt.text = self?.MonthBtnDropDown.dataSource[index]
            print(self?.monthTxt.text ?? "ok")
        }
    }
    
    //MARK: - IMAGE PICKER SETUP
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileBtnImg.setBackgroundImage(image, for: .normal)
            profileBtnImg.setTitle(" ", for: .normal)
            
            userImg = compressImage(image, to: CGSize(width: CGFloat(CONSTANT.DP_IMAGE_WIDTH), height: CGFloat(CONSTANT.DP_IMAGE_HEIGHT)))
        }
    }
    
    //MARK: - BUTTON CLICK EVENT
    @IBAction func ClickToMonth(_ sender: Any) {
        MonthBtnDropDown.show()
    }
    
    @IBAction func ClickToChooseFile(_ sender: Any) {
         self.view.endEditing(true)
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
   
    @IBAction func ClickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        
        var date:String = ""
        if let index:Int = MonthBtnDropDown.indexForSelectedRow{
            let monthIndex:Int = index + 1
            let indexStr:String = monthIndex < 10 ? "0" + String(monthIndex) : String(monthIndex)
            date = yearTxt.text! + "/" + indexStr + "/" + datetxt.text!
        }
    
        if FirstnameTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_first_name", comment: ""))
        }
        else if lastnameTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_last_name", comment: ""))
        }
        else  if professionTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_profession", comment: ""))
        }
        else if emailTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("enter_email", comment: ""))
        }
        else if emailTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("invalid_email", comment: ""))
        }
        else if monthTxt.text?.trimmed.count == 0
        {
            displayToast(NSLocalizedString("select_month", comment: ""))
        }
        else  if datetxt.text?.trimmed.count == 0
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
        else if getDateFromString(date, currFormat: DATE_FORMAT.BIRTHDAY_DATE) == nil
        {
            displayToast(String(format: NSLocalizedString("enter_date", comment: "")))
        }
        else  if passwordTxt.text?.count == 0
        {
            displayToast(NSLocalizedString("enter_password", comment: ""))
        }
        else  if resetPasswordTxt.text?.count == 0
        {
            displayToast(NSLocalizedString("repeat_new_password", comment: ""))
        }
        else if resetPasswordTxt.text != passwordTxt.text
        {
            displayToast(NSLocalizedString("repeat_pwd_not_match", comment: ""))
        }
        
        else {
        
             AppModel.shared.currentUser = UserModel()
             AppModel.shared.currentUser.userFirstName = self.FirstnameTxt.text?.trimmed
             AppModel.shared.currentUser.userMiddleName = self.middlenameTxt.text?.trimmed
             AppModel.shared.currentUser.userLastName = self.lastnameTxt.text?.trimmed
             AppModel.shared.currentUser.userProfession = self.professionTxt.text?.trimmed
             AppModel.shared.currentUser.userEmail = self.emailTxt.text?.trimmed
             AppModel.shared.currentUser.userGender = String(maleSwitch.isOn ? 1 : 2)
             AppModel.shared.currentUser.userBirthday = date
             AppModel.shared.currentUser.userHideBday = String(hideDOBSwitch.isOn ? 1 : 0)
             AppModel.shared.currentUser.userHideYear = String(hideyearSwitch.isOn ? 1 : 0)
             AppModel.shared.currentUser.userPassword = self.passwordTxt.text?.trimmed
             
            var imgData : Data = Data()
            if let imageData = userImg.jpegData(compressionQuality: 1){
                imgData = imageData
            }
            LoginSignupService.shared.serviceCallToSignup(imgData, completion: {
               AppDelegate().sharedDelegate().navigateToDashboard(2)
            })
        }
    }
    
    @IBAction func clickToHideDOB(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func ClickToHideYear(_ sender: Any){
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
    @IBAction func ClickToBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK:- textfield delegate
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string == ""){
            return true
        }
        
        var maxLength:Int = 0
        var str:String = ""
        
         if (textField == FirstnameTxt){
            maxLength = CONSTANT.MAX_FIRST_NAME_CHAR
            str = FirstnameTxt.text!
        }
        else if (textField == middlenameTxt){
            maxLength = CONSTANT.MAX_MIDDLE_NAME_CHAR
            str = middlenameTxt.text!
        }
        else if (textField == lastnameTxt){
            maxLength = CONSTANT.MAX_LAST_NAME_CHAR
            str = lastnameTxt.text!
        }
        else if(textField == datetxt){
            maxLength = CONSTANT.DOB_DATE_CHAR
            str = (datetxt.attributedText?.string)!
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
        if textField == FirstnameTxt
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
            datetxt.becomeFirstResponder()
        }
        else if textField == datetxt
        {
            yearTxt.becomeFirstResponder()
        }
        else if textField == yearTxt
        {
            passwordTxt.becomeFirstResponder()
        }
        else if textField == passwordTxt
        {
            resetPasswordTxt.becomeFirstResponder()
        }
        else if textField == resetPasswordTxt
        {
            resetPasswordTxt.resignFirstResponder()
        }
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
