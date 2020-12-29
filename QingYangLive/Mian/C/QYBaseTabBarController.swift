//
//  QYBaseTabBarController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

class QYBaseTabBarController: UITabBarController {
    fileprivate lazy var tabBarArray:[(norTColor:UIColor,selectedColor:UIColor,norImage:UIImage,selectedImage:UIImage,title:String)] = {
        return [
          (RGBColor(85,85,85),RGBColor(51,51, 51),UIImage(named: "home_df")!,UIImage(named: "home_sl")!,"首页"),
          (RGBColor(85,85,85),RGBColor(51,51, 51),UIImage(named: "live_df")!,UIImage(named: "live_sl")!,"直播"),
          (RGBColor(85,85,85),RGBColor(51,51, 51),UIImage(named: "follow_df")!,UIImage(named: "follow_sl")!,"关注"),
          (RGBColor(85,85,85),RGBColor(51,51, 51),UIImage(named: "personal_df")!,UIImage(named: "personal_sl")!,"我的")
          ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///初始化tabbar
        setTabBarProperty()
        ///添加控制器
        createChildVC()
        // Do any additional setup after loading the view.
    }

    // MARK: - 设置tabBar
    fileprivate func setTabBarProperty() {
        tabBar.isTranslucent=false
        //不确定是iOS13还是xcode11问题，暂时先使用全局设置
        UITabBar.appearance().tintColor = RGBColor(227, 95,78)
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = RGBColor(51, 51,51)
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:RGBColor(227, 95,78)], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:RGBColor(51, 51,51)], for: .normal)
        }

     }
    // MARK: - 添加子控制器
    func createChildVC() {
        addChild(QYBaseNavigationViewController(rootViewController: QYHomeController()))
        
        addChild(QYBaseNavigationViewController(rootViewController: QYLiveController()))
        
        addChild(QYBaseNavigationViewController(rootViewController: QYFollowController()))
        
        addChild(QYBaseNavigationViewController(rootViewController: QYPersonalController()))
        
        setDefaultTabSource()
    }

    func setDefaultTabSource() {
        
        tabBar.barTintColor = .white
        
        for (index,childVC) in children.enumerated() {

            let tuple = tabBarArray[index]
            
            setVCTabbarProps(childVC,tuple.title,tuple.norTColor,tuple.selectedColor,tuple.norImage,tuple.selectedImage)

        }
    }
    func setVCTabbarProps(_ vc:UIViewController,_ title:String,_ norTitleColor:UIColor,_ selTitleColor:UIColor,_ norImg:UIImage,_ selImg:UIImage) {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:norTitleColor], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:selTitleColor], for: .selected)
        vc.tabBarItem.image = norImg.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selImg.withRenderingMode(.alwaysOriginal)
        
    }
    // MARK: - tabbar 点击事件
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "直播" {
            QYLog(item.title)
        }
    }
}
