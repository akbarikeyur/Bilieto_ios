//
//  UIView+RUI.swift
//  Juicer
//
//  Created by ToShare Pty. Ltd. on 2/18/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit

public extension UIView {
    public func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                
                var parsedViewController : UIViewController = parentResponder as! UIViewController
                while parsedViewController.parent != nil {
                    parsedViewController = parsedViewController.parent!
                }
                
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
