//
//  PageTitleView.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit
// MARK:- 定义常量
private let kSlideLineH : CGFloat = 2

class PageTitleView: UIView {
    //MARK: -定义属性
    private var titles:[String]
    
    private lazy var labels:[UILabel] = [UILabel]()
    
    //MARK: - 懒加载
    private var scrollView:UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.MainColor()
        return scrollView
    }()
    
    private lazy var slideLine:UIView = {
        let slideView =  UIView()
        slideView.backgroundColor = UIColor.MainSelectedTitleColor()
        return slideView
    }()

    //MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        super.init(frame: frame);
        //设置UI界面
        initSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - 设置UI界面
extension PageTitleView{
    private func initSubviews(){
        //1. 添加UIScrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //2. 添加label标签
        setUiTitleLabels()
        
        //3. 添加滚动条 slideLine
        setBottomLineWithSlideLine()
    }
    
    private func setUiTitleLabels(){
        //0. 添加局部变量
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = bounds.height
        let labelY:CGFloat = 0
        
        for (index, title) in titles.enumerated()  {
            //1. 创建label
            let subview = UILabel()
            //2. 设置label属性
            subview.text = title as String
            subview.textColor = UIColor.MainTitleColor()
            subview.font = FontPFRegularSize(14)
            subview.textAlignment = .center
            //3. 设置label frame
            let labelX:CGFloat = labelW*CGFloat(index)
            subview.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //3. 将label添加入scrollView
            scrollView.addSubview(subview)
            labels.append(subview)
        }
    }
    
    private func setBottomLineWithSlideLine(){
        //使用轻量级对象
        let bottomLine = CALayer()
        let bottonLineHeight:CGFloat = 1.0
        bottomLine.backgroundColor = UIColor.NavColor_gray().cgColor
        bottomLine.frame = CGRect(x:0, y:bounds.size.height - bottonLineHeight, width:bounds.size.width, height: bottonLineHeight)
        scrollView.layer.addSublayer(bottomLine)

        //校验第一个对象是否为空
        guard let firstLabel = labels.first else{ return }
        firstLabel.textColor = UIColor.MainSelectedTitleColor()
        scrollView.addSubview(slideLine)
        slideLine.frame = CGRect(x:firstLabel.frame.origin.x, y:bounds.size.height - kSlideLineH, width: firstLabel.frame.size.width, height: kSlideLineH)
    }
}
