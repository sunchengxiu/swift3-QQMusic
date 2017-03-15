//
//  SCXPopAnimation.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXPopAnimation: NSObject {
    
    var isPresent : Bool = true
    
    
    /// 点击弹出动画的时候回调方法
    var callBack : ((_ presented : Bool) -> ())?
    
    init(callBack : @escaping ((_ isPresent : Bool) -> ())) {
        
        self.callBack = callBack
        
    }
    
    

}

// MARK: - 自定义转场frame , 通过UIPresentationController代理方法 ， 设置弹出的大小和动画
extension SCXPopAnimation : UIViewControllerTransitioningDelegate{
    
    /// 控制弹出控制器的大小
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return SCXPresentationController(presentedViewController: presented, presenting: presenting)
        
    }
    
    /// 监听弹出或者消失
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = true;
        
        callBack!(isPresent)
        
        return self
        
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = false
        
        callBack!(isPresent)
        
        return self
    }


}

// MARK: - 设置弹出和消失的动画
extension SCXPopAnimation : UIViewControllerAnimatedTransitioning{
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    //获取转场上下文，通过上下文来获取弹出的View和消失的View
    //UITransitionContextViewKey.to 获取弹出的View
    //UITransitionContextViewKey.from 获取小时的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresent {
            SCX_PresentedAnimation(transitionContext: transitionContext)
        }
        else{
        
            SCX_DismissedAnimation(transitionContext: transitionContext)
        }
    }
    
    /// 自定义弹出动画
    ///
    /// - Parameter transitionContext: 上下文
    fileprivate func SCX_PresentedAnimation(transitionContext : UIViewControllerContextTransitioning){
        
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        presentView?.isUserInteractionEnabled = true
        if presentView != nil{
        
            transitionContext.containerView.addSubview(presentView!)
            
            // 从下往上面弹出
            presentView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            presentView?.transform = CGAffineTransform(scaleX: 1, y: 0)
           
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
                presentView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (presented) in
                transitionContext.completeTransition(true)
            })
        
        }
        
    
    }
    
    /// 自定义消失动画
    ///
    /// - Parameter transitionContext: 上下文
    fileprivate func SCX_DismissedAnimation(transitionContext : UIViewControllerContextTransitioning){
        
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        if presentView != nil {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
                presentView?.transform = CGAffineTransform(scaleX: 1.0, y: 0)
            }, completion: { (dismiss) in
                presentView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
        
        
    }
}
