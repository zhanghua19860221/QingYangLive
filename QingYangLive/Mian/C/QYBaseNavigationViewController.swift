//
//  QYBaseNavigationViewController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

class QYBaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationBar.isTranslucent=false
        navigationBar.titleTextAttributes=[NSAttributedString.Key.font:FontPFMediumSize(18),NSAttributedString.Key.foregroundColor:RGBColor(51,51,51)]
        //设置 导航栏 颜色
        navigationBar.barTintColor = UIColor.white
        //仅用这句话去掉导航栏下面的线,在10系统以上管用,10线依然存在,解决办法找UI要图,再设个背景图就好了
        navigationBar.shadowImage = UIImage()
        //compact让导航及时更新样式 让导航彻底透明
        //navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.compact)
        //不让透明图片影响状态栏
        //self.navigationController?.navigationBar.layer.masksToBounds = true
        //设置导航栏头视图
        //navigationItem.titleView = UIImageView(image: UIImage(named: ""))
        
        interactivePopGestureRecognizer?.delegate=self
        
        //设置添加全屏返回手势
        reSetPopGestureRecognizer()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0{
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(image: UIImage(named: "nav_left_bk"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftBtnDidClick))
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    @objc func leftBtnDidClick(){
        popViewController(animated: true)
    }
    
    override var childForStatusBarStyle: UIViewController?{
        
        return visibleViewController
    }
    
    func getImageFromView() -> UIImage {
        
        //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        
        view.layer.render(in: context!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
}
extension QYBaseNavigationViewController:UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return children.count != 1
    }
    
    //重新设置返回手势 改为全屏返回
    fileprivate func reSetPopGestureRecognizer(){
        //1. 获取系统Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return}
        
        //2. 通过手势获取 此手势被添加的view
        guard let gesView = systemGes.view else{return}
        
        //3. 获取target/action
        //3.1利用运行时机制查看所有的属性名称
        /**
         var count : UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
         for i in 0..<count {
             let ivar = ivars[Int(i)]
             let name = ivar_getName(ivar)
             print(String(cString: name!))
         }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }

        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }

        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}
