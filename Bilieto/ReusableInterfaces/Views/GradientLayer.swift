//
//  GradientLayer.swift
//  YourHealthWallet
//
//  Created by ToShare Pty. Ltd. on 2/1/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import UIKit

class GradientLayer: CAGradientLayer {

    override func layoutSublayers() {
        super.layoutSublayers()
        
        frame = super.bounds
    }
}
