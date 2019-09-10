//
//  DataModel.swift
//  Bilieto
//
//  Created by pc1 on 03/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation
import EVReflection

class DataModel : EVObject, Codable{
    
    var data:String!
    var status:Int!
    var status_message:String!
    var ttl:Int!
    
    required init() {
        
    }
}
