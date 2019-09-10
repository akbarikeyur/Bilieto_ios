//
//  StyleModel.swift
//  Bilieto
//
//  Created by pc1 on 10/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//


import Foundation
import EVReflection

class StyleDataModel : EVObject, Codable {
    
    var status : Int!
    var status_message: String!
    var ttl: Int!
    var data: [StyleModel]!
    
    required init() {
        
    }
    
}


class StyleModel : EVObject, Codable{
    
    var styleID : String!
    var styleName: String!
    var price: String!
    var imageURL: String!
    
    required init() {
        
    }
    
}
