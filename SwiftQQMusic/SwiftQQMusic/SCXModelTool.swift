//
//  SCXModelTool.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/11.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXModelTool: NSObject {
    
    class func SCX_getMusicModel() -> (([SCXMusicModel]) ) {
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            return  [SCXMusicModel]()
        }
        guard let modelArr = NSArray(contentsOfFile: path)  else {
            return [SCXMusicModel]()
        }
        var models = [SCXMusicModel]()
        
        for dic in modelArr{
            let model = SCXMusicModel(dic: dic as! [String : AnyObject])
            models.append(model)
        }
        return models
    }

}
