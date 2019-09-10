//
//  Fonts.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd. on 2/18/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit

var Bold41Font : UIFont = UIFont(name: "Helvetica-Bold", size: 41.0)!
var Bold40Font : UIFont = UIFont(name: "Helvetica-Bold", size: 40.0)!
var Bold27Font : UIFont = UIFont(name: "Helvetica-Bold", size: 27.0)!
var Bold26Font : UIFont = UIFont(name: "Helvetica-Bold", size: 26.0)!
var Bold25Font : UIFont = UIFont(name: "Helvetica-Bold", size: 25.0)!
var Bold24Font : UIFont = UIFont(name: "Helvetica-Bold", size: 24.0)!
var Bold23Font : UIFont = UIFont(name: "Helvetica-Bold", size: 23.0)!
var Bold22Font : UIFont = UIFont(name: "Helvetica-Bold", size: 22.0)!
var Bold21Font : UIFont = UIFont(name: "Helvetica-Bold", size: 21.0)!
var Bold20Font : UIFont = UIFont(name: "Helvetica-Bold", size: 20.0)!
var Bold19Font : UIFont = UIFont(name: "Helvetica-Bold", size: 19.0)!
var Bold18Font : UIFont = UIFont(name: "Helvetica-Bold", size: 18.0)!
var Bold17Font : UIFont = UIFont(name: "Helvetica-Bold", size: 17.0)!
var Bold16Font : UIFont = UIFont(name: "Helvetica-Bold", size: 16.0)!
var Bold15Font : UIFont = UIFont(name: "Helvetica-Bold", size: 15.0)!
var Bold14Font : UIFont = UIFont(name: "Helvetica-Bold", size: 14.0)!
var Bold13Font : UIFont = UIFont(name: "Helvetica-Bold", size: 13.0)!
var Bold12Font : UIFont = UIFont(name: "Helvetica-Bold", size: 12.0)!
var Bold11Font : UIFont = UIFont(name: "Helvetica-Bold", size: 11.0)!
var Bold10Font : UIFont = UIFont(name: "Helvetica-Bold", size: 10.0)!

var Regular27Font : UIFont = UIFont(name: "Helvetica", size: 27.0)!
var Regular26Font : UIFont = UIFont(name: "Helvetica", size: 26.0)!
var Regular25Font : UIFont = UIFont(name: "Helvetica", size: 25.0)!
var Regular24Font : UIFont = UIFont(name: "Helvetica", size: 24.0)!
var Regular23Font : UIFont = UIFont(name: "Helvetica", size: 23.0)!
var Regular22Font : UIFont = UIFont(name: "Helvetica", size: 22.0)!
var Regular21Font : UIFont = UIFont(name: "Helvetica", size: 21.0)!
var Regular20Font : UIFont = UIFont(name: "Helvetica", size: 20.0)!
var Regular19Font : UIFont = UIFont(name: "Helvetica", size: 19.0)!
var Regular18Font : UIFont = UIFont(name: "Helvetica", size: 18.0)!
var Regular17Font : UIFont = UIFont(name: "Helvetica", size: 17.0)!
var Regular16Font : UIFont = UIFont(name: "Helvetica", size: 16.0)!
var Regular15Font : UIFont = UIFont(name: "Helvetica", size: 15.0)!
var Regular14Font : UIFont = UIFont(name: "Helvetica", size: 14.0)!
var Regular13Font : UIFont = UIFont(name: "Helvetica", size: 13.0)!
var Regular12Font : UIFont = UIFont(name: "Helvetica", size: 12.0)!
var Regular11Font : UIFont = UIFont(name: "Helvetica", size: 11.0)!
var Regular10Font : UIFont = UIFont(name: "Helvetica", size: 10.0)!

enum FontType : String {
    case Clear = ""
    case Bold41 = "B41"
    case Bold40 = "B40"
    case Bold27 = "B27"
    case Bold26 = "B26"
    case Bold25 = "B25"
    case Bold24 = "B24"
    case Bold23 = "B23"
    case Bold22 = "B22"
    case Bold21 = "B21"
    case Bold20 = "B20"
    case Bold19 = "B19"
    case Bold18 = "B18"
    case Bold17 = "B17"
    case Bold16 = "B16"
    case Bold15 = "B15"
    case Bold14 = "B14"
    case Bold13 = "B13"
    case Bold12 = "B12"
    case Bold11 = "B11"
    case Bold10 = "B10"
    
    case Regular27 = "R27"
    case Regular26 = "R26"
    case Regular25 = "R25"
    case Regular24 = "R24"
    case Regular23 = "R23"
    case Regular22 = "R22"
    case Regular21 = "R21"
    case Regular20 = "R20"
    case Regular19 = "R19"
    case Regular18 = "R18"
    case Regular17 = "R17"
    case Regular16 = "R16"
    case Regular15 = "R15"
    case Regular14 = "R14"
    case Regular13 = "R13"
    case Regular12 = "R12"
    case Regular11 = "R11"
    case Regular10 = "R10"
}


extension FontType {
    var value: UIFont {
        get {
            switch self {
            case .Clear:
                return Regular14Font
            case .Bold41:
                return Bold41Font
            case .Bold40:
                return Bold40Font
            case .Bold27:
                return Bold27Font
            case .Bold26:
                return Bold26Font
            case .Bold25:
                return Bold25Font
            case .Bold24:
                return Bold24Font
            case .Bold23:
                return Bold23Font
            case .Bold22:
                return Bold22Font
            case .Bold21:
                return Bold21Font
            case .Bold20:
                return Bold20Font
            case .Bold19:
                return Bold19Font
            case .Bold18:
                return Bold18Font
            case .Bold17:
                return Bold17Font
            case .Bold16:
                return Bold16Font
            case .Bold15:
                return Bold15Font
            case .Bold14:
                return Bold14Font
            case .Bold13:
                return Bold13Font
            case .Bold12:
                return Bold12Font
            case .Bold11:
                return Bold11Font
            case .Bold10:
                return Bold10Font
               
            case .Regular27:
                return Regular27Font
            case .Regular26:
                return Regular26Font
            case .Regular25:
                return Regular25Font
            case .Regular24:
                return Regular24Font
            case .Regular23:
                return Regular23Font
            case .Regular22:
                return Regular22Font
            case .Regular21:
                return Regular21Font
            case .Regular20:
                return Regular20Font
            case .Regular19:
                return Regular19Font
            case .Regular18:
                return Regular18Font
            case .Regular17:
                return Regular17Font
            case .Regular16:
                return Regular16Font
            case .Regular15:
                return Regular15Font
            case .Regular14:
                return Regular14Font
            case .Regular13:
                return Regular13Font
            case .Regular12:
                return Regular12Font
            case .Regular11:
                return Regular11Font
            case .Regular10:
                return Regular10Font
            }
        }
    }
}
