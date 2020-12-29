//
//  EXT_UIBarButtonItem.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit
extension UIBarButtonItem{
    /// 创建构造函数 convenience（便利构造函数修饰符）
    /// - Parameters:
    ///   - imageName: 默认图片
    ///   - highImageName: 点击高亮图片
    ///   - size: itemSize
    convenience init(imageName : String, highImageName : String, size : CGSize) {
        let buttonItem = UIButton();
        buttonItem.setImage(UIImage(named: imageName), for: .normal)
        buttonItem.setImage(UIImage(named: highImageName), for: .highlighted)
        buttonItem.frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(customView:buttonItem)
    }
//    //创建类方法
//    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem{
//        let buttonItem = UIButton();
//        buttonItem.setImage(UIImage(named: imageName), for: .normal)
//        buttonItem.setImage(UIImage(named: highImageName), for: .highlighted)
//        buttonItem.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: buttonItem)
//    }
    
}
