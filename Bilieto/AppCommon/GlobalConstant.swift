//
//  GlobalConstant.swift
//  SRIMCA
//
//  Created by ToShare Pty. Ltd on 9/22/17.
//  Copyright © 2017 ToShare Pty. Ltd. All rights reserved.
//

import Foundation
import UIKit

let BASE_URL = "http://api.bilieto.com/user/"

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

//"yyyy-MM-dd HH:mm:ss Z"

struct DATE_FORMAT {
    static let BIRTHDAY_DATE = "yyyy-MM-dd"
    static let SERVER_DATE = "yyyy-MM-dd HH:mm:ss"
}

struct TIME_FORMAT {
    static let DISP_PICKUPTIME_TIME = "HH:mm"
}

struct CONSTANT{
    
    static let MAX_EMAIL_CHAR = 254
    static let MAX_PREFER_NAME_CHAR = 40
    static let MAX_FIRST_NAME_CHAR = 40
    static let MAX_MIDDLE_NAME_CHAR = 40
    static let MAX_LAST_NAME_CHAR = 40
    
    static let DOB_CHAR = 8
    static let DOB_DATE_CHAR = 2
    static let DOB_YEAR_CHAR = 4
    static let DOB_SPACE_CHAR = 4
    
    static let MOBILE_NUMBER_CHAR = 8
    static let MOBILE_NUMBER_SPACE_CHAR = 2
    static let MOBILE_NUMBER_CODE = "04"
    
    static let CARD_NUMBER_CHAR = 16
    static let CARD_NUMBER_DASH_CHAR = 3
    static let CARD_EXP_DATE_CHAR = 5
    static let CARD_CVV_CHAR = 3
    
    static let SMS_CODE_CHAR = 4
    static let SMS_CODE_SPACE_CHAR = 3
    
    static let DP_IMAGE_WIDTH     =  200
    static let DP_IMAGE_HEIGHT    =  200
    static let IMAGE_QUALITY   =  1
    
    static let CURRENCY   =  "$"
    static let DIST_MEASURE   =  "km"
    static let TIME_ZONE = "Australia/Sydney"
    
    static let DEF_TAKE:Int = 24
 
}

struct STORYBOARD {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    static let MYBILIETO = UIStoryboard(name: "MyBilietoTab", bundle: nil)
}


struct NOTIFICATION
{
   
}
