//
//  QYHomeController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

class QYHomeController: QYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RandomColor()
        //初始化UI界面
        initSubviews()
        //自定义导航栏
        setNavgationBar()
        
        // Do any additional setup after loading the view.
    }
}
//MARK: - 初始化UI界面
extension QYHomeController{
    //创建UI
    private func initSubviews(){
        
    }
    //自定义导航栏
    private func setNavgationBar(){
        //设置左侧item
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "nav_left_logo"), for: .normal)
        leftButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        //设置右侧item
        //方法一 拓展 UIBarButtonItem 构造函数 系统推荐
        let itemSize = CGSize(width: 40, height: 40)
        let historyItem  = UIBarButtonItem(imageName: "nav_history_grey", highImageName: "nav_history_colour", size: itemSize)
        let searchItem  = UIBarButtonItem(imageName: "nav_search_grey", highImageName: "nav_search_colour", size: itemSize)
        let scanItem  = UIBarButtonItem(imageName: "nav_scan_grey", highImageName: "nav_scan_colour", size: itemSize)
//        //方法二 拓展 UIBarButtonItem 类方法 不建议使用
//        let historyItem  = UIBarButtonItem.createItem(imageName: "nav_history_grey", highImageName: "nav_history_colour", size: itemSize)
//        let searchItem  = UIBarButtonItem.createItem(imageName: "nav_search_grey", highImageName: "nav_search_colour", size: itemSize)
//        let scanItem  = UIBarButtonItem.createItem(imageName: "nav_scan_grey", highImageName: "nav_scan_colour", size: itemSize)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}
