//
//  SCXLrcView.swift
//  SwiftQQMusic
//
//  Created by 孙承秀 on 2017/3/12.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

import UIKit

class SCXLrcView: UITableViewController {
    
    lazy var SCX_Mid_lrcLabel = UILabel()
    
    var SCX_Mid_LrcLabelText : String? = ""
    
    var lrcModels = [SCXLrcModel](){
    
        didSet{
        
            if lrcModels == oldValue {
                return
            }
            tableView.reloadData()
        }
    
    }
    var currentCell : SCXLrcTableViewCell?
    
    var lrcOldCell : SCXLrcTableViewCell?
    
    var old_Index : Int = 0
    
    
    var lrcProgress : CGFloat = 0.0{
    
        didSet{
            
            if currentCell != nil {
                
                autoUpdateLrc()
               
            }
            
            
            
        }
    
    }
    
    
    var Lrc_Index : Int = 0 {
        
        didSet{
            
            if Lrc_Index == oldValue {
                return
            }
            
            // 滚动到制定的位置
            // 新的indexPath
            let indexPath = NSIndexPath(row: Lrc_Index, section: 0  )
            self.tableView.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: true)
             let cell = self.tableView.cellForRow(at: indexPath as IndexPath)
            currentCell = cell as! SCXLrcTableViewCell?
            // 旧的indexPath
            let oldIndexpath = NSIndexPath(row: oldValue, section: 0)
            let oldCell = self.tableView.cellForRow(at: oldIndexpath as IndexPath) as? SCXLrcTableViewCell
            old_Index = oldValue
            lrcOldCell = oldCell
            cell?.addAnimation(animationType: .scaleAlways)
            oldCell?.addAnimation(animationType: .scaleNormal)
            
            oldCell?.lrcCell_textLabel?.progress = 0
        }
        
    }
    
    
    
    /// 基本配置
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SCX_SetUpLrcTableViewFrame(frame : CGRect)  {
        self.view.frame = frame
    }
   

}
extension SCXLrcView {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SCXLrcTableViewCell.SCX_CellForRowWithTableView(tableView: tableView)
        
        let lrcModel = lrcModels[indexPath.row]
        
        cell.lrcModel = lrcModel
        if indexPath.row == Lrc_Index {
            // 保持之前的动画，要不然滑动列表的时候动画就消失了
            cell.addAnimation(animationType: .scaleAlways)
            cell.lrcCell_textLabel?.progress = lrcProgress
        }else {
            cell.addAnimation(animationType: .scaleNormal)
            cell.lrcCell_textLabel?.progress = 0
        }
        
        return cell
        
        
    }
}
extension SCXLrcView{

    /// 自动更新歌词进度方法
    fileprivate func autoUpdateLrc()  {
        let lrcModel = lrcModels[Lrc_Index]
        lrcModel.progress = lrcProgress
        lrcModels[Lrc_Index] = lrcModel
        let indexPath = NSIndexPath(row: Lrc_Index, section: 0) as IndexPath

        let count = self.tableView.visibleCells
        if count.count <= 0 || indexPath.row > lrcModels.count - 1 {
            return
        }
        
        guard (self.tableView.cellForRow(at:indexPath ) != nil)  else {
            return
        }
        let cell = self.tableView.cellForRow(at:indexPath )
        
        
// MARK: - 这个地方特别奇怪，必须重新赋值一下currentCell，要不然就会出现类似于重用的现象，往下滑动的时候，会给下面的也复制，currentcell不是最新的
        if cell != nil {
            currentCell = cell as? SCXLrcTableViewCell
            currentCell?.lrcCell_textLabel?.progress = lrcProgress
        }
        
    }

}
// MARK: - 自动划过来之后防止颜色消失,集成自scrollViewDelegate
extension SCXLrcView {
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       autoUpdateLrc()
    }

}

