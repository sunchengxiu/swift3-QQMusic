//
//  SCXBaseViewController.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
import SnapKit

/// 定义一个按钮点击闭包
typealias btnClickBlock = (_ left : Bool)-> ()
class SCXBaseViewController: UIViewController {

    var closeBlock : btnClickBlock?
    
    var moreBlock : btnClickBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - 控制器操作
extension SCXBaseViewController {
    
    /// present一个控制器
    ///
    /// - Parameter vc: 要推出的控制器
    func SCX_presentViewController(vc : UIViewController?)  {
        if vc != nil {
            self.present(vc!, animated: true, completion: {
                
            })
        }
    }
    
    func SCX_dismissViewController(vc : UIViewController?)  {
        if vc != nil {
            vc?.dismiss(animated: true, completion: { 
                
            })
        }
    }
    

}

// MARK: - 设置类似于导航栏左右按钮
extension SCXBaseViewController {

    func setNavigationItem(_ left : Bool , imageName : String , clickBlock : @escaping (_ left : Bool) -> ())  {
        
        self.closeBlock = clickBlock
        
        self.moreBlock = clickBlock
        
        let btn : UIButton = UIButton()
         view.addSubview(btn)
        if left {
            
            
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(view).offset(10)
                make.top.equalTo(view).offset(50)
                make.width.equalTo(50)
                make.height.equalTo(50)
            })
            btn.addTarget(self, action: #selector(leftBtnClick), for: UIControlEvents.touchUpInside)
           
        }
        else{
            btn.snp.makeConstraints({ (make) in
                make.right.equalTo(view).offset(-10)
                make.top.equalTo(view).offset(50)
                make.width.equalTo(50)
                make.height.equalTo(50)
            })
            btn.addTarget(self, action: #selector(rightBtnClick), for: UIControlEvents.touchUpInside)
            
        }
        
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        
        view.bringSubview(toFront: btn)
    }

}

// MARK: - 按钮点击事件
extension SCXBaseViewController {

    @objc fileprivate func leftBtnClick()  {
        if (self.closeBlock != nil) {
            closeBlock!(true)
        }
    }
    @objc fileprivate func rightBtnClick()  {
        if (self.moreBlock != nil) {
            self.moreBlock!(false)
        }
    }
}

// MARK: - 处理状态栏
extension SCXBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
        
    }
    
    
}


