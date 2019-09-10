//
//  ProfileWebViewVC.swift
//  Bilieto
//
//  Created by pc1 on 13/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class ProfileWebViewVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let str = "http://beta.bilieto.com/bilieto/bilietomobile/" + "\(AppModel.shared.currentUser.userID!)"
        let url = URL(string: str)
        webView.loadRequest(URLRequest(url: url!))
        
    
    NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
    
    
}

@objc func dropDownSelection(noti : Notification)
{
    let vc : UIViewController = UIApplication.topViewController()!
    if (vc is ProfileWebViewVC) {
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
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if index == 2
            {
                let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "OptionsVC") as! OptionsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if index == 3
            {
                let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
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
    if (vc is ProfileWebViewVC) {
        let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
