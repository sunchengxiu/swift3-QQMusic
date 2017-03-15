//
//  SCXRotationAnimation.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/13.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXRotationAnimation: NSObject {

    class func SCX_RotationAnimation(layer : CALayer )  {
        layer.removeAllAnimations()
        layer.removeAnimation(forKey: "layerAnimation")
        SCX_ResumeAnimation(layer: layer)
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: "layerAnimation")
        
    }
    
    /// 暂停动画
    class func SCX_PauseAnimation(layer : CALayer)  {
        let pauseTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0
        layer.timeOffset = pauseTime
    }
    
    /// 继续动画
    class func SCX_ResumeAnimation(layer :CALayer)  {
        let pauseTIme = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0;
        layer.beginTime = 0
        let pauseOffset = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTIme
        
        layer.beginTime = pauseOffset
        
        
    }
}
