//
//  PageTitleView.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//

import UIKit

/// 添加class 表明此协议只能被类遵守
protocol  PageTitleViewDelegate :class{
    func pageTitleView(_ titleView:PageTitleView, selectedIndex index:Int)
    
}
// MARK:- 定义常量
private let kSlideLineH : CGFloat = 2

class PageTitleView: UIView {
    //MARK: -定义属性
    private var titles:[String]
    //记录当前下标
    private var currentIndex:Int = 0
    
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载
    private lazy var labels:[UILabel] = [UILabel]()

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
            subview.tag = index
            subview.text = title as String
            subview.textColor = UIColor.MainTitleColor()
            subview.font = FontPFRegularSize(14)
            subview.textAlignment = .center
            //3. 设置label frame
            let labelX:CGFloat = labelW*CGFloat(index)
            subview.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4. 将label添加入scrollView
            scrollView.addSubview(subview)
            labels.append(subview)
            //5. 给Label添加点击手势
            subview.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(labelClick(tapGes:)))
            subview.addGestureRecognizer(tapGes)
        }
    }
    
    private func setBottomLineWithSlideLine(){
        //使用轻量级对象
        let bottomLine = CALayer()
        let bottonLineHeight:CGFloat = 1.0
        bottomLine.backgroundColor = UIColor.NavColor_gray().cgColor
        bottomLine.frame = CGRect(x:0, y:bounds.size.height - bottonLineHeight, width:bounds.size.width, height: bottonLineHeight)
        scrollView.layer.addSublayer(bottomLine)

        //校验第一个对象是否为空 （为空直接返回）
        guard let firstLabel = labels.first else{ return }
        firstLabel.textColor = UIColor.MainSelectedTitleColor()
        scrollView.addSubview(slideLine)
        slideLine.frame = CGRect(x:firstLabel.frame.origin.x, y:bounds.size.height - kSlideLineH, width: firstLabel.frame.size.width, height: kSlideLineH)
    }
}
//MARK: -监听Label的点击事件
extension PageTitleView{
    @objc private func labelClick(tapGes:UITapGestureRecognizer){
        //1. 获取当前点击的 视图 (没有获取到的话直接返回)
        guard let currentLabel = tapGes.view as? UILabel else{ return }
        currentLabel.textColor = UIColor.NavColor_orange()
        
        //2. 如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        //3. 获取之前点击的 视图 (没有获取到的话直接返回)
        let oldLabel = labels[currentIndex]
        oldLabel.textColor = UIColor.MainTitleColor()
        
        //4. 保存currentIndex
        currentIndex = currentLabel.tag
        
        //5. 更改slideFrame
        UIView.animate(withDuration: 0.25) {
            self.slideLine.frame.origin.x = currentLabel.frame.origin.x
        }
        
        //6. 通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

//MARK: -对外暴露的方法
extension PageTitleView{

    /// 切换标签状态
    /// - Parameters:
    ///   - progress: 偏移比例
    ///   - sourceIndex: 滑动前index
    ///   - tagetIndex: 滑动后index
    func setCurrentPageIndex(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        // 1.取出sourceLabel/targetLabel
        let tagetLabel = labels[targetIndex]
        let sourceLabel = labels[sourceIndex]

        //2. 更改slideFrame
        let moveTotalX = tagetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        self.slideLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3. 新旧label颜色设置顺序不能 颠倒
        sourceLabel.textColor = UIColor.MainTitleColor()
        tagetLabel.textColor = UIColor.NavColor_orange()
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
