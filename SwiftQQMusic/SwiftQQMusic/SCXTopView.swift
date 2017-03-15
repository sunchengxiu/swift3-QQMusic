//
//  SCXTopView.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXTopView: UIView {
    
    
    /// 头部歌曲名字Label
    lazy var SCX_Top_MusicNameLabel : UILabel = UILabel()
    
    /// 头部作者名字Label
    lazy var SCX_Top_nameLabel : UILabel = UILabel()
    
    /// 头部歌曲名字
    var SCX_Top_MusicName : String?{
        didSet{
            SCX_Top_MusicNameLabel.text = SCX_Top_MusicName
            //layoutIfNeeded()
        }
    
    }
    
    /// 头部作者名字
    var SCX_Top_Name : String?{
    
        didSet{
            SCX_Top_nameLabel.text = SCX_Top_Name
            //layoutIfNeeded()
        }
    }
    
    
    /// 重写init方法，设置默认设置的东西
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(SCX_Top_MusicNameLabel)
        addSubview(SCX_Top_nameLabel)
        SCX_CommonSetUp()
        
    }
    func SCX_updateTopView(model : SCXMusicModel)  {
        SCX_Top_Name = model.singer
        SCX_Top_MusicName = model.name
        SCX_Top_nameLabel.text = SCX_Top_Name
        SCX_Top_MusicNameLabel.text = SCX_Top_MusicName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        SCX_Top_MusicNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
        }
        
        SCX_Top_nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(SCX_Top_MusicNameLabel.snp.bottom).offset(15
            )
            make.centerX.equalTo(self)
        }
        
    }
    
    
}

// MARK: - 头部试图配置
extension SCXTopView{
    
    func SCX_CommonSetUp()  {
        SCX_Top_MusicNameLabel.textColor = UIColor.white
        SCX_Top_MusicNameLabel.font = UIFont.systemFont(ofSize: 20)
        SCX_Top_nameLabel.textColor = UIColor.white
        SCX_Top_nameLabel.font = UIFont.systemFont(ofSize: 17)
    }

}
