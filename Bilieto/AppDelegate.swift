//
//  AppDelegate.swift
//  Bilieto
//
//  Created by Amisha on 4/3/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import DropDown
import Alamofire
import AlamofireImage
import AlamofireJsonToObjects
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var isKeyboardOpen:Bool = false
    var activityLoader : NVActivityIndicatorView!
    var customTabbarVc : CustomTabBarController!
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        AppModel.shared.currentUser = UserModel()
        if let user: UserModel = getSavedUser()
        {
            AppModel.shared.currentUser = user
            navigateToDashboard()
        }
        
        return true
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("amishapadasala20@gmail.com")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }

    @objc func keyboardDidShow(_ notif:NSNotification){
        isKeyboardOpen = true
    }
    
    @objc func keyboardDidHide(_ notif:NSNotification){
        isKeyboardOpen = false
    }
    
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func navigateToDashboard(_ index:Int = 0)
    {
        customTabbarVc = (STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController)
        if let rootNavigatioVC : UINavigationController = self.window?.rootViewController as? UINavigationController
        {
            customTabbarVc.selectedindex = index
            rootNavigatioVC.pushViewController(customTabbarVc, animated: false)
        }
    }
   
    func navigateToLogin() {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ViewControllerNavigation") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = navigationVC
    }
   
    //MARK:- Redirect func.

    func logout(){
        AppModel.shared.currentUser = nil
        removeAllUserDefaultValue()
        navigateToLogin()
    }

  //  //MARK:- Other func.
    
   func showLoader()
    {
        removeLoader()
        window?.isUserInteractionEnabled = false
        activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        activityLoader.type = .ballSpinFadeLoader
        activityLoader.color = AppColor
        window?.addSubview(activityLoader)
        activityLoader.startAnimating()
    }

    func removeLoader()
    {
        window?.isUserInteractionEnabled = true
        if activityLoader == nil
        {
            return
        }
        activityLoader.stopAnimating()
        activityLoader.removeFromSuperview()
        activityLoader = nil
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
