//
//  ViewController.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: SCXBaseViewController , UITableViewDelegate , UITableViewDataSource {

    /*************  懒加载 ***************/
    fileprivate var tableView : SCXQQMusicTableView = SCXQQMusicTableView()
    
    
    var detailVc : SCXDetailViewController?
    
    
    lazy var SCX_PopAnimation = SCXPopAnimation { (isPresent) in
        
    }
    
    var models = [SCXMusicModel]()
    
    
    /*************  生命周期 ***************/
    override func viewDidLoad() {
        
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        automaticallyAdjustsScrollViewInsets = true
        loadData()
        
        SCX_SetUpTableView()
        SCX_monorEarphoneToggleControl()
        
        
    }
}

// MARK: - 加载数据
extension ViewController {

    fileprivate func loadData () -> (){
    
        
        let  models = SCXModelTool.SCX_getMusicModel()
        self.models = models
        SCXMusicMidTool.shareInstance.models = models;
    }
}


// MARK: - 搭建界面
extension ViewController {
    
    fileprivate func SCX_SetUpTableView (){
    
        tableView.frame = self.view.bounds;
        
        tableView.frame.origin.y = 0
        
        let imageView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        
        tableView.backgroundView = imageView
        
        tableView.backgroundColor = UIColor.clear
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        
        view.addSubview(tableView)
    
    }

}

// MARK: - tableView代理方法
extension ViewController{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell  = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        if cell == nil {
            cell = SCXTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        
        cell?.textLabel?.text = models[indexPath.row].name;
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .gray
        // 给cell添加动画
        cell?.addAnimation(animationType: .scale)
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true )
        
        detailVc = SCXDetailViewController.shareInstance
        
        
        detailVc?.SCX_Music_Model = models[indexPath.row]
        
        detailVc?.modalPresentationStyle = .custom
        
        detailVc?.transitioningDelegate = SCX_PopAnimation
        
        SCXMusicMidTool.shareInstance.SCX_PlayMusic(model: models[indexPath.row])
       
        SCX_presentViewController(vc: detailVc)
        
        
    }
}

// MARK: - 监听耳机线控事件
extension ViewController{
    
    func SCX_monorEarphoneToggleControl()  {
        do{
            try AVAudioSession.sharedInstance().setActive(true)
            // 监听
            NotificationCenter.default.addObserver(self, selector: #selector(SCX_HandleToggle(note:)), name: NSNotification.Name.AVAudioSessionRouteChange, object: nil)
        }catch{
            
            print(error)
            
        }
    }
    func SCX_HandleToggle(note : Notification)  {
        let userInfo = note.userInfo
        let key : AVAudioSessionRouteChangeReason = AVAudioSessionRouteChangeReason( rawValue: userInfo?[AVAudioSessionRouteChangeReasonKey] as! UInt)!
        
        
        let model = SCXMusicMidTool.shareInstance.SCX_updatePlayModel()
        //SCX_Music_Model = model
        
        switch key {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable:
            
            /// 必须在主线程中进行！！！！！！！！！！！！！！！！！坑死我了，基因为没有写主线程 ，所以一直崩溃，一直找原因没有找到，
            DispatchQueue.main.async {
                SCXMusicMidTool.shareInstance.SCX_PlayMusic(model: model)
                self.detailVc?.SCX_updateDetailView(model: model, play: true, rotationType: .resume)
            }
            
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable:
            print("播出耳机了")
            DispatchQueue.main.async {
                SCXMusicMidTool.shareInstance.SCX_PauseMusic()
                
                self.detailVc?.SCX_updateDetailView(model: model, play: false, rotationType: .pause)
            }
            
        default:
            break
            
        }
        
    }
    
}



