//
//  Preference.swift
//  Cozy Up
//
//  Created by Keyur on 18/05/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
    
    let USER_LATITUDE_KEY       =   "USER_LATITUDE"
    let USER_LONGITUDE_KEY      =   "USER_LONGITUDE"
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: key)
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - User login boolean
func setDeviceToken(value: String)
{
    setDataToPreference(data: value as AnyObject, forKey: "push_device_token")
}

func getDeviceToken() -> String
{
    if let deviceToken = getDataFromPreference(key: "push_device_token")
    {
        return deviceToken as! String
    }
    return ""
}

func setUserLocation(_ latitude : Float, longitude : Float)
{
    setDataToPreference(data: latitude as AnyObject, forKey: Preference.sharedInstance.USER_LATITUDE_KEY)
    setDataToPreference(data: longitude as AnyObject, forKey: Preference.sharedInstance.USER_LONGITUDE_KEY)
}

func getUserLatitude() -> Float
{
    if let temp : Float = getDataFromPreference(key: Preference.sharedInstance.USER_LATITUDE_KEY) as? Float
    {
        return temp
    }
    return 0.0
}

func getUserLongitude() -> Float
{
    if let temp : Float = getDataFromPreference(key: Preference.sharedInstance.USER_LONGITUDE_KEY) as? Float
    {
        return temp
    }
    return 0.0
}

func setModuleType(value: Int)
{
    setDataToPreference(data: value as AnyObject, forKey: "user_type")
}

func isUserModule() -> Bool
{
    if let type = getDataFromPreference(key: "user_type") as? Int
    {
        if type == 1
        {
            return true
        }
        else
        {
            return false
        }
    }
    return true
}

