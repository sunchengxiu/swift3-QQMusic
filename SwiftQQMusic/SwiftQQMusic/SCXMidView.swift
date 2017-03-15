//
//  SCXMidView.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXMidView: UIScrollView {
    
    var SCX_Mid_iconView = SCXIconView()
    
    var SCX_Mid_LrcView = SCXLrcView(style: .plain)
    
    var SCX_IconName : String?
    
    var SCX_MusicModel : SCXMusicModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        
        showsHorizontalScrollIndicator = false
        
        isPagingEnabled = true
        
        contentSize = CGSize(width: SCX_ScreenWidth * 2, height: 0)
        
        //  专辑图片试图配置
        SCX_Mid_iconView = SCXIconView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        addSubview(SCX_Mid_iconView)
        
        // 歌词试图配置
        SCX_Mid_LrcView.SCX_SetUpLrcTableViewFrame(frame: CGRect(x: SCX_ScreenWidth, y: 0, width: frame.size.width, height: frame.size.height))
        SCX_Mid_LrcView.tableView.allowsSelection = false
        SCX_Mid_LrcView.tableView.backgroundColor = .clear
        SCX_Mid_LrcView.tableView.separatorStyle = .none
        SCX_Mid_LrcView.tableView.contentInset = UIEdgeInsets(top: frame.size.height / 2, left: 0, bottom: frame.size.height / 2, right: 0)
        addSubview(SCX_Mid_LrcView.view)
    }
    
    /// 更新歌词试图
    func SCX_UpdateLrcView(model : SCXMusicModel)  {
        
        
        var  lrcArr = [SCXLrcModel]()
        if (model.lrcModels?.count)! > 0 {
            lrcArr  = model.lrcModels!
        }
        else{
            // 获取这首歌所有歌词，然后把每一句歌词转化为一个模型，存到数组，然后得到这个歌词数组
            lrcArr =  SCXMusicModel.SCX_UpdateLrcView(model: model)
        }
        
        // 这区这一行歌词的模型
        let lrc = SCXMusicMidTool.SCX_updateCurrentLrc(models: lrcArr)

        // 歌词实时变化当前时间
        let currentTime = model.musicModel?.music_preTime
        // 歌词开始时间
        let beginTime = lrc?.Lrc_beginTime
        // 歌词结束的时间
        let endTime = lrc?.Lrc_endTime
        
        if currentTime != nil && beginTime != nil && endTime != nil {
            // 计算本句歌词走过的时长
            let time = currentTime! - beginTime!
            let timeAll = endTime! - beginTime!
            let progress = time / timeAll
            
            // 实时更新专辑界面的歌词
            SCX_Mid_iconView.SCX_UpdateCurrentLrc(model: lrc!, progress: CGFloat( progress + 0.1))
            if lrc?.Lrc_content != nil {
                
                // 实时更新歌词界面的歌词，让tableView滚动
                SCX_Mid_LrcView.Lrc_Index = lrcArr.index(of: lrc!)!
                
                SCX_Mid_LrcView.lrcProgress = CGFloat(progress)
            }
        }
      
        
        
        
        
        
    }
 
    /// 更新中间试图
    func SCX_UpdateMidView(model : SCXMusicModel) {
        SCX_MusicModel = model
        SCX_IconName = model.icon
        SCX_Mid_iconView.SCX_SetUpView(model: SCX_MusicModel!)
        // 更新歌词界面的歌词
        let  lrcArr = SCXMusicModel.SCX_UpdateLrcView(model: model)
        SCX_Mid_LrcView.lrcModels = lrcArr
       
        SCX_UpdateLrcView(model: model)
        
    }
    func SCX_IconAnimation(rotationType: SCXRotationType) {
      SCX_Mid_iconView.SCX_IconAnimation(rotationType: rotationType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
        
    }
}


extension SCXMidView : UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let spreed = contentOffset.x / SCX_ScreenWidth
        
        SCX_Mid_iconView.alpha = 1 - spreed
        
        SCX_Mid_LrcView.tableView.alpha = spreed
        
    }

}


