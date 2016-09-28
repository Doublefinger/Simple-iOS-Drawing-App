//
//  ColorPallet.swift
//  Lab3
//
//  Created by Shitianyu Pan on 9/26/16.
//  Copyright © 2016 Doublefinger. All rights reserved.
//

import UIKit

class ColorPallet: UIButton {
    init(color: UIColor, index: Int, y: CGFloat){
        let x : CGFloat = 30 + 55 * CGFloat(index)
        super.init(frame: CGRectMake(x, y, 40, 40))
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}