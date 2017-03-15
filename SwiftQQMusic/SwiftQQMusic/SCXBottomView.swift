//
//  SCXBottomView.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
import MediaPlayer
enum SCXRotationType {
    case begin
    case pause
    case resume
}
class SCXBottomView: UIView {

    
    /// 懒加载试图
    lazy var SCX_Bottom_preTimeLabel : UILabel = UILabel()
    
    lazy var SCX_Bottom_LastTimeLabel : UILabel = UILabel()
    
    lazy var SCX_Bottom_ProgressView : UISlider = UISlider()
    
    lazy var SCX_Bottom_PreMusicBtn : UIButton = UIButton()
    
    lazy var SCX_Bottom_NextMusicBtn : UIButton = UIButton()
    
    lazy var SCX_Bottom_PalyBtn : UIButton = UIButton()
    
    var delegate : SCXBottomViewDelegate?
    
    
    
    /// 各个控件参数
    var SCX_Bottom_PreTime : String? = "00:00"{
    
        didSet{
        
            SCX_Bottom_preTimeLabel.text = SCX_Bottom_PreTime
        }
    
    }
    
    var SCX_Bottom_NextTime : String? = "00:00"{
    
        didSet{
        
            SCX_Bottom_LastTimeLabel.text = SCX_Bottom_NextTime
        
        }
    
    }
    
    var SCX_Bottom_Pregress : Float = 0{
    
        didSet{
        
            SCX_Bottom_ProgressView.value = SCX_Bottom_Pregress
        
        }
    
    }
  
    override init(frame: CGRect) {
        
        super.init(frame: frame)
         
        commomSetUp()
        
    }
 
    /// 更新底部视图
    func SCX_UpdateBottomView(model : SCXMusicModel , play : Bool)  {
        
        SCX_Bottom_PalyBtn.isSelected = play
        if model.musicModel?.music_preText == nil || model.musicModel?.music_preText == "" {
            model.musicModel?.music_preText = "00:00"
        }
        if model.musicModel?.music_lastText == nil || model.musicModel?.music_lastText == "" {
            model.musicModel?.music_lastText = "00:00"
        }
        
        SCX_Bottom_PreTime = model.musicModel?.music_preText
        SCX_Bottom_NextTime = model.musicModel?.music_lastText
        SCX_Bottom_preTimeLabel.text = SCX_Bottom_PreTime
        SCX_Bottom_LastTimeLabel.text = SCX_Bottom_NextTime
        if model.musicModel?.music_preTime == nil {
        
            SCX_Bottom_Pregress = 0
        
        }
        else{
        
             SCX_Bottom_Pregress = Float( (model.musicModel?.music_preTime)!) / Float((model.musicModel?.music_totalTime)!)
        }
       
        SCX_Bottom_ProgressView.value = SCX_Bottom_Pregress
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        SCX_Bottom_preTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(10)
        }
        
        SCX_Bottom_LastTimeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-5)
            make.top.equalTo(self).offset(10)
        }
        
        SCX_Bottom_ProgressView.snp.makeConstraints { (make) in
            make.left.equalTo(SCX_Bottom_preTimeLabel.snp.right).offset(5)
            make.right.equalTo(SCX_Bottom_LastTimeLabel.snp.left).offset(-5)
            make.top.equalTo(self).offset(10)
        }
        
        SCX_Bottom_PreMusicBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-SCX_ScreenWidth / 3)
                make.centerY.equalTo(self)
                make.width.height.equalTo(70)
            
        }
        
        SCX_Bottom_PalyBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            
            make.width.height.equalTo(80)
        }
        
        SCX_Bottom_NextMusicBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(SCX_ScreenWidth / 3)
            make.centerY.equalTo(self)
            make.width.height.equalTo(70)
        }
        
    }

}

// MARK: - 初始化设置
extension SCXBottomView{

    
    /// 基本配置
    func commomSetUp()  {
        
        // 添加试图到self上面
        addSubview(SCX_Bottom_preTimeLabel)
        addSubview(SCX_Bottom_ProgressView)
        addSubview(SCX_Bottom_LastTimeLabel)
        addSubview(SCX_Bottom_PreMusicBtn)
        addSubview(SCX_Bottom_PalyBtn)
        addSubview(SCX_Bottom_NextMusicBtn)
        
// MARK: - 文件基本配置
        SCX_Bottom_preTimeLabel.textColor = .white
        SCX_Bottom_LastTimeLabel.textColor = .white
        SCX_Bottom_preTimeLabel.font = .systemFont(ofSize: 10)
        SCX_Bottom_LastTimeLabel.font = .systemFont(ofSize: 10)
        SCX_Bottom_preTimeLabel.text = SCX_Bottom_PreTime
        SCX_Bottom_LastTimeLabel.text = SCX_Bottom_NextTime
        
        SCX_Bottom_ProgressView.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
        SCX_Bottom_ProgressView.tintColor = .green
        // 值改变的时候
        SCX_Bottom_ProgressView.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        // 天机手势
        SCX_Bottom_ProgressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture(tap:))))
// MARK: - 设置按钮图片
    SCX_Bottom_PreMusicBtn.setImage(UIImage(named:"player_btn_pre_highlight"), for: .highlighted)
        SCX_Bottom_PreMusicBtn.setImage(UIImage(named:"player_btn_pre_normal"), for: .normal)
        SCX_Bottom_PalyBtn.setImage(UIImage(named:"player_btn_play_highlight"), for: .highlighted)
        SCX_Bottom_PalyBtn.setImage(UIImage(named:"player_btn_pause_normal"), for: .selected)
        SCX_Bottom_PalyBtn.setImage(UIImage(named:"player_btn_play_normal"), for: .normal)
        
        SCX_Bottom_NextMusicBtn.setImage(UIImage(named:"player_btn_next_normal"), for: .normal)
        SCX_Bottom_NextMusicBtn.setImage(UIImage(named:"player_btn_next_highlight"), for: .highlighted)
        
// MARK: - 添加点击事件
        SCX_Bottom_PalyBtn.addTarget(self, action: #selector(SCX_PlayMusic(btn:)), for: .touchUpInside)
        SCX_Bottom_PreMusicBtn.addTarget(self, action: #selector(SCX_preMusic), for: .touchUpInside)
        SCX_Bottom_NextMusicBtn.addTarget(self, action: #selector(SCX_nextMusic), for: .touchUpInside)
    }

}

// MARK: - 按钮点击事件
extension SCXBottomView{

    
    /// 播放或者暂停音乐
    @objc fileprivate func SCX_PlayMusic(btn : UIButton)  {
        
        SCX_Bottom_PalyBtn.isSelected = !SCX_Bottom_PalyBtn.isSelected
        
        if !SCX_Bottom_PalyBtn.isSelected {
            // 暂停音乐
            SCXMusicMidTool.shareInstance.SCX_PauseMusic()
            delegate?.SCX_ModelChange(play: false , rotationType: .pause)
        }
        else{
        
            // 播放音乐
            print("播放音乐")
            SCXMusicMidTool.shareInstance.SCX_PlayCurrentMusic()
            delegate?.SCX_ModelChange(play: true , rotationType: .resume)
        
        }
        
        
    }
    
    /// 下一曲
    @objc fileprivate func SCX_nextMusic()  {
        
        SCX_Bottom_PalyBtn.isSelected = true
        
        SCXMusicMidTool.shareInstance.SCX_NextMusic()
        
        delegate?.SCX_ModelChange(play: true , rotationType: .begin)
        
    }
    
    /// 上一曲
    @objc fileprivate func SCX_preMusic()   {
        
        SCX_Bottom_PalyBtn.isSelected = true
        
        SCXMusicMidTool.shareInstance.SCX_PreMusic()
        
        delegate?.SCX_ModelChange(play: true , rotationType: .begin)
        
    }
}

// MARK: - 处理进度条相关事件，来处理进度
extension SCXBottomView{

    
    /// 进度条值改变的时候
    func valueChange()  {
        
        // 获取当前进度条的值
        let value = SCX_Bottom_ProgressView.value
        SCX_HandlePlayerTimer(value: CGFloat(value))
 
    }
    /// 点击手势的时候
    func tapGesture(tap : UITapGestureRecognizer)  {
        
        /// 获取手指在slider上面的位置
        let point = tap.location(in: SCX_Bottom_ProgressView)
        let touch_X = point.x
        
        // 相对于slider的比例
        let value = touch_X / SCX_Bottom_ProgressView.frame.size.width
        SCX_Bottom_ProgressView.value = Float(value)
        SCX_HandlePlayerTimer(value: value)
    }
    func SCX_HandlePlayerTimer(value : CGFloat)  {
        // 获取当前音乐model
        let currentModel = SCXMusicMidTool.shareInstance.SCX_updatePlayModel()
        
        //计算进度条相对于总时间的进度
        let currentTime = (currentModel.musicModel?.music_totalTime)! * TimeInterval(value)
        
        // 赋值给模型
        currentModel.musicModel?.music_preTime = currentTime
        
        // 获取已经播放的时间字符串
        SCX_Bottom_PreTime = currentModel.musicModel?.music_preText
        
        // 给label赋值
        SCX_Bottom_preTimeLabel.text = SCX_Bottom_PreTime
        
        // 将播放器定位到制定时间
        SCXMusicMidTool.shareInstance.SCX_SeekToTime(time: currentTime)
    }

}


/// 底部试图代理方法
protocol SCXBottomViewDelegate{

    func SCX_ModelChange(play : Bool , rotationType : SCXRotationType)

}
