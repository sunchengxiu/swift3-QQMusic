//
//  SCXTimeTool.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXTimeTool: NSObject {

    
    /// 将时间转化为文字标准字符串
    class func SCX_timeConver(timeInterval : TimeInterval) -> (String) {
        
        let min  = Int(timeInterval) / 60
        
        let sec = Int(timeInterval) % 60
        
        let str = String(format: "%02d:%02d", min , sec)
        
        
        return str
        
    }
    
    /// 将时间字符串转化为时间
    class func SCX_ConverTimeStrToTime(timeStr : String?) -> TimeInterval {
        
        let timeArr = timeStr?.components(separatedBy: ":")
        
        if timeArr?.count != 2 {
            return 0
        }
        let min = TimeInterval((timeArr?.first)!) ?? 0.0
        let sec = TimeInterval((timeArr?.last)!) ?? 0.0
        
        return min * 60 + sec
        
        
    }
    
    
}
