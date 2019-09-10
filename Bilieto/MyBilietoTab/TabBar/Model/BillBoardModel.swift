//
//  BillBoardModel.swift
//  Bilieto
//
//  Created by pc1 on 23/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation
import EVReflection

class BillModel: EVObject, Codable {
    
    var status : Int!
    var status_message: String!
    var ttl: Int!
    var data: [BillBoardModel]!
    
    required init() {
        
    }
}


class BillBoardModel : EVObject, Codable {
    
    var userID : String!
    var boardID: String!
    var boardType: String!
    var boardVisibility: String!
    var boardPinability: String!
    var boardNeedsApproval: String!
    var boardDescription: String!
    var boardTitle: String!
    var boardLocation: String!
    var boardHashTags: String!
    var boardUserName: String!
    var boardPosition: String!
    var boardPartsNum: String!
    var boardPartsNames: String!
    var boardStatus: String!
    
    var userUniqueName : String!
    var boardModified : String!
    var userImageURL : String!
    
  
    required init() {
        
    }
}


class GetBillModel: EVObject, Codable {
    
    var status : Int!
    var status_message: String!
    var ttl: Int!
    var data: GetBillBoardModel!
    
    required init() {
        
    }
}


class GetBillBoardModel : EVObject, Codable {
    
    var boardInfo : [BillBoardModel]!
    var boardCards : [GetBoardCardModel]!
    
    required init() {
        
    }
}

class GetBoardCardModel : EVObject, Codable {
    
    var boardID : String!
    var cardUserID : String!
    var cardPosition : String!
    var boardPart : String!
    var boardTypeParams : String!
    var bilietoID : String!
    var cardImage : String!
    var cardImageSmall : String!
    var cardImageMed : String!
    
    
    required init() {
        
    }
}



