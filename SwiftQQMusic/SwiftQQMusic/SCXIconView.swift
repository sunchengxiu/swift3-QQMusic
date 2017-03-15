//
//  SCXIconView.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXIconView: UIView {
    
    lazy var SCX_mid_imageView = UIImageView()
    
    lazy var SCX_mid_textLabel : SCXBaseLabel = SCXBaseLabel()
    
    var SCX_musicModel : SCXMusicModel?
    
    
    
    
    var SCX_mid_imageName : String?{
        
        didSet{
            
            SCX_mid_imageView.image = UIImage(named: SCX_mid_imageName!)
            
        }
        
    }
    var SCX_mid_text : String? = "告白气球"{
        
        didSet{
            
            SCX_mid_textLabel.text = SCX_mid_text
            
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(SCX_mid_imageView)
        addSubview(SCX_mid_textLabel)
        SCX_mid_textLabel.textColor = .white
        SCX_mid_textLabel.font = .systemFont(ofSize: 15)
        SCX_mid_imageView.layer.cornerRadius = (SCX_ScreenWidth - 20) / 2
        SCX_mid_imageView.layer.masksToBounds = true
        
    }
    func SCX_IconAnimation(rotationType: SCXRotationType) {
        switch rotationType {
        case .begin:
            SCXRotationAnimation.SCX_RotationAnimation(layer:  SCX_mid_imageView.layer)
        case .pause:
            SCXRotationAnimation.SCX_PauseAnimation(layer:  SCX_mid_imageView.layer)
        default:
            SCXRotationAnimation.SCX_ResumeAnimation(layer:  SCX_mid_imageView.layer)
        }
       
    }
    
    /// 实时更新歌词
   
    func SCX_UpdateCurrentLrc(model : SCXLrcModel , progress : CGFloat)  {
        
        // 实时对应的歌词
        SCX_mid_text = model.Lrc_content
        SCX_mid_textLabel.text = model.Lrc_content
        
        SCX_mid_textLabel.progress = progress
        
        
    }
    func SCX_SetUpView(model : SCXMusicModel)  {
        SCX_musicModel = model
        SCX_mid_imageName = model.icon;
        // 实时对应的歌词
        SCX_mid_text = model.name
        SCX_mid_textLabel.text = model.name

        SCX_mid_imageView.image = UIImage(named: SCX_mid_imageName!)
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        SCX_mid_imageView.snp.makeConstraints { (make) in
            make.width.equalTo(SCX_ScreenWidth - 20)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(SCX_mid_imageView.snp.width)
            make.top.equalTo(self)
        }
        
        SCX_mid_textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(SCX_mid_imageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            
        }
        
    }
}


