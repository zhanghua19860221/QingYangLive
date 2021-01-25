//
//  QYBaseViewController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

class QYBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppMainColor()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //导航栏的展示与隐藏
        //navigationController?.setNavigationBarHidden(true, animated: false)
        //隐藏导航栏不影响返回手势 控制器需要遵守 UIGestureRecognizerDelegate 协议
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //结束时取消隐藏导航栏
        //navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: -- 析构函数
    deinit {
        //释放通知
        NotificationCenter.default.removeObserver(self)
        
        var name =  type(of: self).description()
        if(name.contains(".")){
          name =  name.components(separatedBy: ".")[1];
          print("控制器\(name) Running \(#function)")
        }else{
          print("控制器\(name) Running \(#function)")
        }
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .default
//    }
}
