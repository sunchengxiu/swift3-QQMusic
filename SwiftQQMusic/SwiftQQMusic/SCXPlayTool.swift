//
//  SCXPlayTool.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
import AVFoundation
class SCXPlayTool: NSObject , AVAudioPlayerDelegate {
    static let shareInstance = SCXPlayTool()
    
    var player : AVAudioPlayer?  {
        didSet{
        
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(AVAudioSessionCategoryPlayback)
                try session.setActive(true)
            }
            catch{
            
                print(error);
                return
            }
        }
    }

    /// 播放
    func SCX_PlayMusic(name : String)  {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            return
        }
       
        if player?.url == url {
            player?.play()
            return
        }
        
        do {
        
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
            
        }
        catch{
            print(error)
            return
            
            
        }
    }
    
    /// 暂停
    func SCX_PauseMusic()  {
        player?.pause()
    }
    
    /// 定位到某个时间
    func SCX_SeekToTime(time : TimeInterval)  {
        player?.currentTime = time
    }
     
}
extension SCXPlayTool {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SCX_PlayFinishNotificationKey), object: nil)
    }
    

}

