//
//  SCXPlayModel.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXPlayModel: NSObject {

    var music_preTime : TimeInterval = 0.0{
    
        
        didSet{
            
            music_preText = SCXTimeTool.SCX_timeConver(timeInterval: music_preTime)
            
        }
    
    }
    
    var music_totalTime : TimeInterval = 0.0{
    
        didSet{
            
            music_lastText = SCXTimeTool.SCX_timeConver(timeInterval: music_totalTime)
        }
    
    }
    
    var music_lastTime : TimeInterval = 0.0
    
    var music_preText : String? = "00:00"
    
    var music_lastText : String? = "00:00"
    
    
    
}
