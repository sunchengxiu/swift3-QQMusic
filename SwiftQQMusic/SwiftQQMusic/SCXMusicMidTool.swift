//
//  SCXMusicMidTool.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
import MediaPlayer
class SCXMusicMidTool: NSObject {
    
    // 单例
    static let shareInstance = SCXMusicMidTool()
    
    // 歌曲模型
    var models = [SCXMusicModel]()
    
    /// 当前歌词
    var currentLrc : String? = ""
    
    var artWorkItem : MPMediaItemArtwork?
    
    
    var currentIndex = -1{
    
        didSet{
        
            if currentIndex < 0  {
                currentIndex = models.count - 1
            }
            if currentIndex > models.count - 1 {
                
                currentIndex = 0
            }
        
        }
    
    }
    
    
    /// 播放音乐
    func SCX_PlayMusic(model : SCXMusicModel)  {
        
        let name = model.filename
        guard name != nil else {
            return
        }
        
        currentIndex = models.index(of: model)!
        
        SCXPlayTool.shareInstance.SCX_PlayMusic(name: name!)
        
    }
    
    /// 播放音乐
    func SCX_PlayCurrentMusic()  {
        
        let model = models[currentIndex]
        guard model.filename != nil else {
            return
        }
        
        SCXPlayTool.shareInstance.SCX_PlayMusic(name: model.filename!)
        
    }
    
    /// 暂停音乐
    func SCX_PauseMusic()  {
        if currentIndex < 0 {
            return
        }
        
        let model = models[currentIndex]
        guard model.filename != nil else {
            return
        }
        SCXPlayTool.shareInstance.SCX_PauseMusic()
        
        
    }
    
    /// 下一曲
    func SCX_NextMusic()  {
        
        currentIndex += 1
        let model =  models[currentIndex]
        
        SCXPlayTool.shareInstance.SCX_PlayMusic(name: model.filename!)
        
        
    }
    
    /// 上一曲
    func SCX_PreMusic()  {
        
        currentIndex -= 1
        let model =  models[currentIndex]
        
        SCXPlayTool.shareInstance.SCX_PlayMusic(name: model.filename!)
    }
    
    /// 将播放器seek到某个时间
    func SCX_SeekToTime(time : TimeInterval)  {
        SCXPlayTool.shareInstance.SCX_SeekToTime(time: time)
    }
    
    /// 获取音乐的播放进度
    func SCX_updatePlayModel() -> (SCXMusicModel) {
        // 容错，防止第一次进来的时候，没有播放歌曲，插入了耳机，那么没有index
        if currentIndex < 0 {
        
            return SCXMusicModel()
        
        }
        let model : SCXMusicModel = models[currentIndex]
        if model.musicModel == nil {
            model.musicModel = SCXPlayModel()
        }
        let musicModel = model.musicModel
        musicModel?.music_preTime = (SCXPlayTool.shareInstance.player?.currentTime)!
        musicModel?.music_totalTime = (SCXPlayTool.shareInstance.player?.duration)!
        return model
        
    }
    
    /// 获取实时对应的那个歌词
   
    class func SCX_updateCurrentLrc(models : [SCXLrcModel]) -> SCXLrcModel? {
        let currentTime = SCXPlayTool.shareInstance.player?.currentTime
        // 当前播放时间的
        for model in models {
            if model.Lrc_beginTime < currentTime! && currentTime! < model.Lrc_endTime {
                
                return model
            }
        }
       return SCXLrcModel()
        
    }
    
    func SCX_MusicBackgroundConfig()  {
        
        
        // 获取锁屏中心
        let center = MPNowPlayingInfoCenter.default()
        // MPMediaItemPropertyAlbumTitle       专辑标题
        // MPMediaItemPropertyAlbumTrackCount  专辑歌曲数
        // MPMediaItemPropertyAlbumTrackNumber 专辑歌曲编号
        // MPMediaItemPropertyArtist           艺术家/歌手
        // MPMediaItemPropertyArtwork          封面图片 MPMediaItemArtwork类型
        // MPMediaItemPropertyComposer         作曲
        // MPMediaItemPropertyDiscCount        专辑数
        // MPMediaItemPropertyDiscNumber       专辑编号
        // MPMediaItemPropertyGenre            类型/流派
        // MPMediaItemPropertyPersistentID     唯一标识符
        // MPMediaItemPropertyPlaybackDuration 歌曲时长  NSNumber类型
        // MPMediaItemPropertyTitle            歌曲名称
        // MPNowPlayingInfoPropertyElapsedPlaybackTime
        let model = models[currentIndex]
        
        let albumTitle = model.name ?? ""
        let artist = model.singer ?? ""
        let artwork = model.icon ?? ""
        let elapsedPlaybackTime = SCXPlayTool.shareInstance.player?.currentTime ?? 0.0
        let durtion = SCXPlayTool.shareInstance.player?.duration ?? 0.0
        
        // 获取歌词
        var lrc : SCXLrcModel? = nil
        if model.lrcModels != nil {
            lrc = SCXMusicMidTool.SCX_updateCurrentLrc(models: model.lrcModels!)!

        }
        else{
        
        }
        
        
        // 初始图片
        let artImage = UIImage(named: artwork)
        var lrcImage : UIImage?
        if currentLrc != lrc?.Lrc_content && artImage != nil && lrc != nil && lrc?.Lrc_content != nil {
            currentLrc = lrc?.Lrc_content
            // 将歌词画到图片上面去
            lrcImage = SCXImageTool.SCX_DraeLrcInImage(image: artImage!, lrc: (lrc?.Lrc_content)!)
        }
        
        
        if lrcImage != nil {
            // 必须将这个变量设置为全局，如果不设置为全局的时候，第二次进来，因为歌词没有改变，所以不走这个方法，呢么就不能绘制图片，这个参数就为空，那么锁屏界面就显示不了图片了
             artWorkItem = MPMediaItemArtwork(image: lrcImage!)
        }
  
        let infoDic :NSMutableDictionary  = [MPMediaItemPropertyAlbumTitle : albumTitle ,
                                             MPMediaItemPropertyArtist : artist ,
                                             
                                             MPNowPlayingInfoPropertyElapsedPlaybackTime : elapsedPlaybackTime ,
                                             MPMediaItemPropertyPlaybackDuration : durtion
                                             ]
        if artWorkItem != nil {
            infoDic.setValue(artWorkItem, forKey: MPMediaItemPropertyArtwork)
        }
        let playInfo = infoDic.copy()
        
        center.nowPlayingInfo = playInfo as? [String : Any]
        // 开始接受远程事件
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        
    }
    
}



