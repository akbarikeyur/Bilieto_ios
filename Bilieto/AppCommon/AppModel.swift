//
//  AppModel.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd on 1/2/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit
import EVReflection
import CoreLocation

class AppModel: EVObject {
    static let shared = AppModel()
    
    var currentUser : UserModel!
    var usersAvatar:[String:UIImage] = [String:UIImage]()
    var photosQueue:[String:Any] = [String:Any]()
    
}

