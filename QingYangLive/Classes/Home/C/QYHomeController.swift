//
//  QYHomeController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit
private let kTitleViewH:CGFloat = 45
class QYHomeController: QYBaseViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var controllers:[UIViewController] = {
        return[QYRecommendationController(),QYGameController(),QYEntertainmentController(),QYFunController()]
    }()

    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: kScreenWidth, height: kTitleViewH))
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()

    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        let size = CGSize(width: kScreenWidth, height: kScreenHeight-kTitleViewH)
        let origin = CGPoint(x: 0, y: kTitleViewH)
        let pageContentView = PageContentView(frame: CGRect(origin: origin, size: size), childVcs: controllers, parentViewController: self)
        pageContentView.backgroundColor = UIColor.white
        pageContentView.delegate = self
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RandomColor()
        //初始化UI界面
        initSubviews()

        // Do any additional setup after loading the view.
    }
}
//MARK: - 初始化UI界面
extension QYHomeController{
    //创建UI
    private func initSubviews(){
        //自定义导航栏
        setNavgationBar()
        //添加pageTitleView
        view.addSubview(pageTitleView)
        //添加pageContentView
        view.addSubview(pageContentView)
        
    }
    //自定义导航栏
    private func setNavgationBar(){
        //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "nav_left_logo")
        
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

//MARK: - 遵守协议 PageTitleViewDelegate
extension QYHomeController:PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentPageIndex(currentIndex: index)
        
    }
}

//MARK: - 遵守协议 PageContentViewDelegate
extension QYHomeController:PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setCurrentPageIndex(progress, sourceIndex: sourceIndex, targetIndex:targetIndex)
    }
}
