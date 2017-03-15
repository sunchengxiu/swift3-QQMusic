//
//  SCXImageTool.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/14.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXImageTool: NSObject {

    
    class func SCX_DraeLrcInImage(image : UIImage , lrc : String) -> UIImage {
        let size = image.size
        
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(x:0, y: 0, width: size.width, height: size.height)
        image.draw(in: rect)
        
        // 设置属性，让文字居中
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let attribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 17) , NSForegroundColorAttributeName : UIColor.green , NSParagraphStyleAttributeName : style]
        
        (lrc as NSString).draw(in: rect, withAttributes: attribute)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage!
        
    }
}
