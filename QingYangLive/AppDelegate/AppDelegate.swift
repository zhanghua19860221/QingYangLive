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
        
        return true
    }



}

