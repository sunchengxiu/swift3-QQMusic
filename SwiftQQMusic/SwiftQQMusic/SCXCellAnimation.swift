//
//  SCXCellAnimation.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
enum SCX_AnimationType {
    case translation
    case scale
    case rotation
    case scaleAlways
    case scaleNormal
}
extension UITableViewCell{

    func addAnimation(animationType : SCX_AnimationType)  {
        switch animationType {
        case .translation:
            
            layer.removeAnimation(forKey: "translation")
                
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.values = [50 , 0 , 50 , 0];
            animation.duration = 0.7
            animation.repeatCount = 1
            layer.add(animation, forKey: "translation")
        
        case .scale:
            
            layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [0.5, 1.0 ];
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)];
            
            layer.add(animation, forKey: "scale")
            
       
            
        case .rotation:
        
            layer.removeAnimation(forKey: "rotation")
        
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [-1 / 6 * M_PI , 0 , 1 / 6 * M_PI , 0];
            animation.duration = 0.7
            animation.repeatCount = 1
            layer.add(animation, forKey: "rotation")
            
        case .scaleAlways :
            //layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [1.0, 1.2 ];
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)];
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards;
            layer.add(animation, forKey: "scale")
            
        case .scaleNormal:
           
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.autoreverses = true
            animation.duration = 0.7
            animation.repeatCount = 1
            animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)];
            
            layer.add(animation, forKey: "scale")
            
        default: break
            
        }
    }

}
