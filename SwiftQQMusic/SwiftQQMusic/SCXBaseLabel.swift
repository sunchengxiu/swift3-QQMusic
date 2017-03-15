//
//  SCXBaseLabel.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/14.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXBaseLabel: UILabel {

    var progress : CGFloat = 0.0 {
    
        didSet{
        
            setNeedsDisplay()
        }
    
    }
    override func draw(_ rect: CGRect) {
        // 必须super
        super.draw(rect)
         UIColor.red.set()
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * progress, height: rect.size.height)
        textColor = .white
      
        UIRectFillUsingBlendMode(newRect, .sourceIn)
    }
    

}
