//
//  AppDelegate.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let TabbarVC = QYBaseTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabbarVC
        window?.makeKeyAndVisible()
        
        return true
    }



}

