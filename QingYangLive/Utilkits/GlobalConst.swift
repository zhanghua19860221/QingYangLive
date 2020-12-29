//
//  GlobalConst.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit
/// 屏幕宽高比例缩放值
let QYScreenWidth = UIScreen.main.bounds.width
let QYScreenHeight = UIScreen.main.bounds.height
let QYScreenZS = QYScreenWidth/375.0

/// 状态栏的高度
let QYStatusBarHeight = UIApplication.shared.statusBarFrame.height

/// 导航栏的高度(加状态栏)
public func kNavHeight() -> CGFloat {
    return (currentViewController().navigationController?.navigationBar.frame.size.height ?? 44.0) + QYStatusBarHeight
}

//判断是否是全面屏(返回true为全面屏)
let isFullScreen = QYScreenWidth/QYScreenHeight > 1.9

let QYTabBarHeight = (49 + safeAreaBottomSpace())

//获取底部安全区域的高度间隙
func safeAreaBottomSpace() -> CGFloat {
  
    var bottomSpace:CGFloat = 0
    
    if #available(iOS 11.0, *) {
        bottomSpace=UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
    }
    
    return bottomSpace
}

//RGB获取 颜色
func RGBColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat, _ a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

//获取随机颜色
func RandomColor() -> UIColor {
    
    return RGBColor(CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)))
}

//全局主题色
let MainColor = UIColor.white
//全局背景色
let BGColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
//全局按钮主背景色
let btnMainColor = UIColor.init(hexadecimal: "FF7D00")
//全局按钮辅背景色
let btnAssistColor = UIColor.init(hexadecimal: "CAA064")
//全局主题色
let AppMainColor = UIColor.init(hexadecimal: "FF7D00")
//全局主题色_红
let AppMainColor_red = UIColor.init(hexadecimal: "F02717")
//全局主题色_蓝
let AppMainColor_blue = UIColor.init(hexadecimal: "3C90D2")
//导航主题色_灰
let NavColor_gray = UIColor.init(hexadecimal: "a9a9a9")
//导航主题色_橙
let NavColor_orange = UIColor.init(hexadecimal: "ff7d00")
//导航主题色_黑
let NavColor_black = UIColor.init(hexadecimal: "423a35")


//平方-简-中黑体 和大小
func FontPFMediumSize(_ fontSize:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Medium", size: fontSize*QYScreenZS)!
}
//平方-简-标准字体 和大小
func FontPFRegularSize(_ fontSize:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Regular", size: fontSize*QYScreenZS)!
}

func QYLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

func QYIOLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
//    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")

    let manager = FileManager.default
    let urlForDocument = manager.urls( for: .documentDirectory,
                                       in:.userDomainMask)
    let url = urlForDocument[0]
    let file = url.appendingPathComponent("Log.txt")
    print("文件: \(file)")
    let exist = manager.fileExists(atPath: file.path)
    if !exist {
           let data = Data(base64Encoded:"aGVsbG8gd29ybGQ=" ,options:.ignoreUnknownCharacters)
           let createSuccess = manager.createFile(atPath: file.path,contents:data,attributes:nil)
           print("文件创建结果: \(createSuccess)")
    }
    let info = "[\(fileName):line:\(lineNumber)]- \(message)"
    try! info.write(toFile: file.path, atomically: true, encoding: String.Encoding.utf8)
}

/// 设备系统版本号
let sysVersion = Float(UIDevice.current.systemVersion) ?? 12


/// 各种框框消失时间
let dismissTime=2

/// 结束编辑
func endEditing(){
 UIApplication.shared.keyWindow?.endEditing(true)
}

///多语言
func QYLocalString(_ key:String) -> String {
    //APPLanguageCountryManager.shared()?.getLanguage()
    //let pathStr=Bundle.main.path(forResource: "en", ofType: "lproj")

//    guard let path = pathStr else {
//        return ""
//    }
//
//    return Bundle(path: path)?.localizedString(forKey: key, value: nil, table: nil) ?? ""
    
    return key
}

/// 当前控制器
public func currentViewController() -> UIViewController {
    
    var result: UIViewController?
    var window = UIApplication.shared.keyWindow
    
    if window?.windowLevel != UIWindow.Level.normal  {
        let windows = UIApplication.shared.windows
        for tmpWin in windows {
            if tmpWin.windowLevel == UIWindow.Level.normal {
                window = tmpWin
                break
            }
        }
    }
    
    result = window?.rootViewController
    
    while true {
        if (result?.presentedViewController != nil) {
            result = result?.presentedViewController!
        } else if result!.isKind(of: UITabBarController.classForCoder()) {
            let tabBar: UITabBarController = result as! UITabBarController
            result = tabBar.selectedViewController!
        } else if result!.isKind(of: UINavigationController.classForCoder()) {
            let nav: UINavigationController = result as! UINavigationController
            result = nav.visibleViewController!
        } else {
            break
        }
    }
    return result!
}

