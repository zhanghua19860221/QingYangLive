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
        
        interactivePopGestureRecognizer?.delegate=self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0{
            viewController.hidesBottomBarWhenPushed=true
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
    
}
