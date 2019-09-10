//
//  CopyingValues.swift
//  
//
//  Created by ToShare Pty. Ltd. on 2/18/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit

extension NSObject {
    func copyValues(fromObject : AnyObject?) {
        
        if fromObject == nil {
            return
        }
        
        let mirrored_object = Mirror(reflecting: fromObject!)
        for (_, attr) in mirrored_object.children.enumerated() {
            if let property_name = attr.label as String! {
                print("Attr \(index): \(property_name) = \(attr.value)")
                
                self.setValue(fromObject!.value(forKey: property_name), forKey: property_name)
            }
        }
    }
}
