//
//  Utility.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd on 22/12/17.
//  Copyright © 2017 ToShare Pty. Ltd. All rights reserved.
//

import UIKit

//MARK:- Date func
func getDateStringFromDate(_ date:Date, format:String) -> String{
    let dateFormmat = DateFormatter()
    dateFormmat.dateFormat = format
    return dateFormmat.string(from: date)
}
func getDateFromString(_ str:String, currFormat:String) -> Date?{
    let dateFormmat = DateFormatter()
    dateFormmat.dateFormat = currFormat
    if let date = dateFormmat.date(from: str){
        return date
    }
    else{
        return nil
    }
}
func getTimeIntFromString(_ str:String) -> Int{
    var arr:[String] = str.components(separatedBy: ":")
    return (Int(arr[0])! * 100) + Int(arr[1])!
}
func getTimeStringFromInt(_ time:Int) -> String{
    let h:Int = Int(time / 100)
    let m:Int = time - (h * 100)
    var hStr:String = String(h)
    var mStr:String = String(m)
    if(hStr.count == 1){
        hStr = "0" + hStr
    }
    if(mStr.count == 1){
        mStr = "0" + mStr
    }
    return hStr+":"+mStr
}

func getDateStringFromString(_ str:String, currFormat:String, format:String) -> String{
    let dateFormmat = DateFormatter()
    if(currFormat != "")
    {
        dateFormmat.dateFormat = currFormat
    }
    if let date = dateFormmat.date(from: str){
        dateFormmat.dateFormat = format
        //dateFormmat.timeZone = TimeZone(identifier: "UTC")
        return dateFormmat.string(from: date)
    }
    else{
        return ""
    }
}
func getDateStringFromStringWithTimeZone(_ str:String, currFormat:String, format:String) -> String{
    let dateFormmat = DateFormatter()
    dateFormmat.timeZone = TimeZone(identifier: CONSTANT.TIME_ZONE)
    
    if(currFormat != "")
    {
        dateFormmat.dateFormat = currFormat
    }
    if let date = dateFormmat.date(from: str){
        dateFormmat.dateFormat = format
        dateFormmat.timeZone = TimeZone.ReferenceType.default
        return dateFormmat.string(from: date)
    }
    else{
        return ""
    }
}

//MARK:- User function
func saveUser()
{
    if let user:UserModel = AppModel.shared.currentUser{
        UserDefaults.standard.set(user.toJsonData(), forKey: "bilieto_user")
        UserDefaults.standard.synchronize()
    }
}

func getSavedUser() -> UserModel?
{
    if let data : Data = UserDefaults.standard.value(forKey: "bilieto_user") as? Data
    {
        do{
            let jsonDecoder = JSONDecoder()
            let decodedLog = try jsonDecoder.decode(UserModel.self, from: data)
            return decodedLog
        }
        catch
        {
            return nil
        }
    }
    return nil
}

func removeAllUserDefaultValue()
{
    UserDefaults.standard.removeObject(forKey:"bilieto_user")
    //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}


//MARK:- Image Function
func compressImage(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img!.jpegData(compressionQuality: CGFloat(CONSTANT.IMAGE_QUALITY))
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

//MARK:- UI Function
func getTableBackgroundViewForNoData(_ str:String, size:CGSize) -> UIView{
    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    noDataLabel.text          = str.decoded
    noDataLabel.textColor     = LightGreyColor
    noDataLabel.font          = Regular18Font
    noDataLabel.textAlignment = .center
    return noDataLabel
}
func sendDetailByRemovingChar(_ str:String, char:String = " ") -> String{
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}
func sendDetailByRemovingChar(_ attrStr:NSAttributedString, char:String = " ") -> String{
    let str:String = attrStr.string
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}
func setUserProfileImage(_ user : UserModel, button : Button)
{
//    if let image : UIImage = AppModel.shared.usersAvatar[user.userID] {
//        button.setBackgroundImage(image, for: .normal)
//    }
//    else{
//        button.setBackgroundImage(UIImage(named:"user_placeholder"), for: .normal)
//        APIManager.shared.serviceCallToGetUserAvatar(user, btn: button)
//    }
}

func displayToast(_ message:String)
{
    AppDelegate().sharedDelegate().window?.makeToast(message)
    if(AppDelegate().sharedDelegate().isKeyboardOpen){
        UIApplication.shared.windows.last!.makeToast(message)
    }
}
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}
func showAlertWithOption(_ title:String, message:String, btns:[String] = ["Yes", "Cancel"],completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
    let myAlert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
    let rightBtn = UIAlertAction(title: btns[0], style: UIAlertAction.Style.default, handler: { (action) in
        completionConfirm()
    })
    let leftBtn = UIAlertAction(title: btns[1], style: UIAlertAction.Style.cancel, handler: { (action) in
        completionCancel()
    })
    myAlert.addAction(rightBtn)
    myAlert.addAction(leftBtn)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}
func displayHeaderViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    //    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: parentview, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 44.0))
    //    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: parentview, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: parentview.frame.size.height - 64))
    parentview.layoutIfNeeded()
}
func showAlert(_ title:String, message:String, completion: @escaping () -> Void){
    let myAlert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{ (action) in
        completion()
    })
    myAlert.addAction(okAction)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
    
}

func displaySubViewWithScaleOutAnim(_ view:UIView){
    view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    view.alpha = 1
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0, options: [], animations: {() -> Void in
        view.transform = CGAffineTransform.identity
    }, completion: {(_ finished: Bool) -> Void in
    })
}
func displaySubViewWithScaleInAnim(_ view:UIView){
    UIView.animate(withDuration: 0.25, animations: {() -> Void in
        view.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        view.alpha = 0.0
    }, completion: {(_ finished: Bool) -> Void in
        view.removeFromSuperview()
    })
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}


//MARK:- Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}


extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
