//
//  SCXLrcTableViewCell.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/14.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXLrcTableViewCell: UITableViewCell {
    var lrcCell_textLabel : SCXBaseLabel? = SCXBaseLabel()
    
    var lrcModel : SCXLrcModel?{
    
        didSet{
           
            contentView.addSubview(lrcCell_textLabel!)
                
            
            lrcCell_textLabel?.progress = (lrcModel?.progress)!
            lrcCell_textLabel?.textAlignment = .center
            lrcCell_textLabel?.textColor = .white
            lrcCell_textLabel?.text = lrcModel?.Lrc_content;
        }
    
    }
    
    /// 更新歌词进度

    func SCX_UpdateLrc(progress : CGFloat)  {
        lrcCell_textLabel?.progress = progress
    }
    
    

    class func SCX_CellForRowWithTableView(tableView : UITableView) -> SCXLrcTableViewCell {
        
        let cellID = "lrccellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SCXLrcTableViewCell
        if cell == nil {
            cell = SCXLrcTableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.backgroundColor = .clear
        }
        return cell!
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lrcCell_textLabel?.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    

}
