//
//  AppDelegate.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let tabbarVC = QYBaseTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
        
        //设置状态栏字体颜色
        //1. infoPlist 文件添加 key View controller-based status bar appearance 为 NO
        //application.statusBarStyle = .lightContent; //（设置为白色）
        return true
    }



}

