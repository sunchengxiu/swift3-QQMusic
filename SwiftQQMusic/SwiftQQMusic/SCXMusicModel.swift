//
//  SCXMusicModel.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXMusicModel: NSObject {
    /** 歌曲名称 */
    var name: String?
    /** 歌曲文件名称 */
    var filename: String?
    /** 歌词文件名称 */
    var lrcname: String?
    /** 歌手名称 */
    var singer: String?
    /** 歌手头像名称 */
    var singerIcon: String?
    /** 专辑头像图片 */
    var icon: String?
    
    // 音乐模型，包括音乐播放时长，总时长，进度等
    var musicModel : SCXPlayModel?
    
    // 歌词模型数组
    var lrcModels : [SCXLrcModel]?
    
   
    
    
    
    
    override init() {
        super.init()
    }
    
    init(dic : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    /// 处理歌词，根据歌词名字找到文件，然后变成歌词，然后分解歌词，吧一个歌词字符串变成一个数组，然后再把这个歌词数组给tableview就变成一个歌词列表了
    class func SCX_UpdateLrcView(model : SCXMusicModel) -> [SCXLrcModel] {
        let url = Bundle.main.url(forResource: model.lrcname, withExtension: nil)
        var lrc = ""
        do{
            lrc = try String(contentsOf: url!)
        }catch{
            
            print(error)
            return [SCXLrcModel]()
        }
        
        let lrecArr =  lrc.components(separatedBy: "\n")
        
        var lrcModelArr = [SCXLrcModel]()
        // 便利拆分歌词
        for lrcIndex in lrecArr{
            
        // 首先处理歌词中无用的东西 // [ti:][ar:][al:]
            if lrcIndex.contains("[ti:") || lrcIndex.contains("[ar:") || lrcIndex.contains("[al:")  {
                continue
            }
            
            let lrcStr = lrcIndex.replacingOccurrences(of: "[", with: "")
        
            let lrcResultArr = lrcStr.components(separatedBy: "]")
            
           
            let lrcModel = SCXLrcModel()
            
            let timeStr = lrcResultArr.first
            let time = SCXTimeTool.SCX_ConverTimeStrToTime(timeStr: timeStr)
            
            lrcModel.Lrc_beginTime = time
            lrcModel.Lrc_content = lrcResultArr.last
            lrcModelArr.append(lrcModel)
        }
        model.lrcModels = lrcModelArr
        // 第一个歌词的结束时间是第二个的开始时间
        for i in 0..<lrcModelArr.count {
            
            if i == lrcModelArr.count - 1 {
                continue
            }
            let  preLrcModel = lrcModelArr[i]
            let nextModel = lrcModelArr[i + 1]
            preLrcModel.Lrc_endTime = nextModel.Lrc_beginTime
            
        }
        return lrcModelArr
        
    }

}
