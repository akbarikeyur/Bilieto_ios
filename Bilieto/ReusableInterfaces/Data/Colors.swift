//
//  Colors.swift
//
//
//  Created by ToShare Pty. Ltd. on 2/18/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var AppColor : UIColor = UIColor(red:0.26, green:0.51, blue:0.70, alpha:1) //2 #4483b5- for Navigation, button
var BlackColor : UIColor = UIColor.black //3 #000000
var ShadowColor : UIColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1) //4 #BFBFBF
var LineColor : UIColor =  UIColor.lightGray //5
var LightGreyColor : UIColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1) //6
var ChooseTempBackGroundColor : UIColor = UIColor(red: 0.28, green: 0.89, blue: 0.76, alpha: 1)
var TitleColor : UIColor = UIColor(red:0.44, green:0.44, blue:0.44, alpha:1) // 17 #707070
var tabmessageColor : UIColor = UIColor(red:0.89, green:0.27, blue:0.52, alpha:1) // 8 #E54587

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case App = 2
    case Black = 3
    case Shadow = 4
    case Line = 5
    case LightGrey = 6
    case BackGround = 7
    case Title = 17
    case Tabmessage = 8
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
            case .Clear: //0
                return ClearColor
            case .White: //1
                return WhiteColor
            case .App: //2
                return AppColor
            case .Black: //3
                return BlackColor
            case .Shadow: //4
                return ShadowColor
            case .Line: //5
                return LineColor
            case .LightGrey: //6
                return LightGreyColor
            case .BackGround: //7
                return ChooseTempBackGroundColor
            case .Title: //17
                return TitleColor
            case .Tabmessage: //8
                return tabmessageColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Blue = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Blue: //1
                gradient.colors = [
                    UIColor(red:0.08, green:0.53, blue:0.8, alpha:1).cgColor,
                    UIColor(red:0.17, green:0.2, blue:0.7, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 1)
            }
            
            return gradient
        }
    }
}

