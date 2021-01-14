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
        //导航栏的展示与隐藏
        //navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
