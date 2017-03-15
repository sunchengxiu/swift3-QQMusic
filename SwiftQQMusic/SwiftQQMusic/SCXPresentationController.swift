//
//  SCXPresentationController.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXPresentationController: UIPresentationController {

    
    /// 控制弹出控制器的大小
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame =  UIScreen.main.bounds
        presentedView?.isUserInteractionEnabled = true
        containerView?.isUserInteractionEnabled = true
        // let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        // 给弹出的试图添加手势
        //presentedView?.addGestureRecognizer(tap)
        // 给背景试图添加手势
        //containerView?.addGestureRecognizer(tap)
        
    }
}
extension SCXPresentationController {

    func dismiss()  {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}
