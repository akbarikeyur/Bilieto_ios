//
// temp.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd. on 2/16/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import Foundation
import EVReflection

class UserDataModel : EVObject, Codable{
    
    var data:UserModel!
    var status:Int!
    var status_message:String!
    var ttl:Int!
    
    required init() {
        
    }
}

class UserModel :EVObject, Codable {
    
    var userID : String!
    var userAccountStatus : String!
    var userFirstName : String!
    var userMiddleName : String!
    var userLastName : String!
    var userProfession : String!
    var userEmail : String!
    var userHideYear : String!
    var userHideBday : String!
    var userGender: String!
    var userBirthday : String!
    var userPhoto : String!
    var userPassword : String!
    var userFullName : String!
    var userUniqueName : String!
    var userBCardType : String!
    var userPasswordSalt : String!
    var userStatus : String!
    var userIsBloking : String!
    var userBCardPlan : String!
    var userCurStatus : String!
    var userType : String!
    var userCardStyle : String!
    
    required init() {
    }
}



