//
//  CustomTabBarController.swift
//  Event Project
//
//  Created by ToShare Pty. Ltd on 20/07/17.
//  Copyright © 2017 ToShare Pty. Ltd. All rights reserved.
//

import UIKit
import DropDown

class CustomTabBarController: UITabBarController, CustomTabBarViewDelegate, HeaderViewDelegate {

    var tabBarView : CustomTabBarView = CustomTabBarView()
    var headerView : HeaderView!
    
    var selectedindex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layoutIfNeeded()
        tabBarView = Bundle.main.loadNibNamed("CustomTabBarView", owner: nil, options: nil)?.last as! CustomTabBarView
        
        tabBarView.delegate = self
        
        addTabBarView()
        
        setup()
        
        headerView = (Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as! HeaderView)
        headerView.delegate = self
        if UIScreen.main.nativeBounds.height == 2436 {
            headerView.constaintHeightTopView.constant = 0
        }
        else {
            headerView.constaintHeightTopView.constant = 20
        }
        displayHeaderViewtoParentView(AppDelegate().sharedDelegate().window, subview: headerView)
        
        if AppModel.shared.currentUser.userPhoto != nil {
            let str = API.IMAGE_PROFILE+"\(AppModel.shared.currentUser.userUniqueName!)"+"/profile/"+"\(AppModel.shared.currentUser.userPhoto!)"
            let url = URL(string: str)
            tabBarView.btn5.sd_setImage(with: url, for: UIControl.State.normal, completed: { (image, error, SDImageCacheType, url) in
                    if image != nil{
                        self.tabBarView.btn5.setBackgroundImage(image, for: .normal)
                        self.tabBarView.btn5.cornerRadius = 15
                        self.tabBarView.btn5.clipsToBounds = true
                    }
            })
        }
        
        tabBarView.chatLbl.layer.cornerRadius = tabBarView.chatLbl.frame.size.height/2
        tabBarView.chatLbl.layer.masksToBounds = true
        
        headerView.notificationLbl.layer.cornerRadius = headerView.notificationLbl.frame.size.height/2
        headerView.notificationLbl.layer.masksToBounds = true
    }
    
    func setup()
    {
        var viewControllers = [UINavigationController]()
        let navController1 : UINavigationController = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVCNavigation") as! UINavigationController
        viewControllers.append(navController1)
        
        let navController2 : UINavigationController = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVCNavigation1") as! UINavigationController
        viewControllers.append(navController2)
        
        let navController3 : UINavigationController = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVCNavigation2") as! UINavigationController
        viewControllers.append(navController3)
        
        let navController4 : UINavigationController = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVCNavigation3") as! UINavigationController
        viewControllers.append(navController4)
        
        let navController5 : UINavigationController = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVCNavigation4") as! UINavigationController
        viewControllers.append(navController5)
        
        self.viewControllers = viewControllers;
        
        if selectedindex == 4
        {
            self.tabBarView.btn5.isSelected = true;
            self.tabSelectedAtIndex(index: 4)
        }
        else
        {
            self.tabBarView.btn1.isSelected = true;
            self.tabSelectedAtIndex(index: 0)
        }
    }
 
    func tabSelectedAtIndex(index: Int) {
        setSelectedViewController(selectedViewController: (self.viewControllers?[index])!, tabIndex: index)
    }
    
    func setSelectedViewController(selectedViewController:UIViewController, tabIndex:Int)
    {
        // pop to root if tapped the same controller twice
        
//        if self.selectedViewController == selectedViewController {
            (self.selectedViewController as! UINavigationController).popToRootViewController(animated: false)
//        }
        super.selectedViewController = selectedViewController
        
    }
   
    func addTabBarView()
    {
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tabBarView)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 60.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: ((UIScreen.main.bounds.size.height == 812) ? -34 : 0)))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        self.view.layoutIfNeeded()
    }
    
    func ClickToCodeScan(sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil )
    }
    
    func onMoreBtnTap(sender: UIButton) {
        let MoreBtnDropDown : DropDown = DropDown()
        MoreBtnDropDown.anchorView = sender
        MoreBtnDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        
        MoreBtnDropDown.dataSource = [
            "  Edit Profile   ",
            "  Change Style   ",
            "  Options    ",
            "  Change Password   ",
            "  Log Out   "
        ]
        
        MoreBtnDropDown.selectionAction = { [weak self] (index, item) in
            
            let dict : [String : Int] = ["index" : index]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: dict)
            
        }
        MoreBtnDropDown.show()
    }
    
    func tabBarHidden() -> Bool
    {
        return self.tabBarView.isHidden && self.tabBar.isHidden
    }
    
    func setTabBarHidden(tabBarHidden:Bool)
    {
        self.tabBarView.isHidden = tabBarHidden
        self.tabBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
