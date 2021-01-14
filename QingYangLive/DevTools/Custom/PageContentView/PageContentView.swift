//
//  PageContentView.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/30.
//

import UIKit
protocol PageContentViewDelegate :class{
    /// 滑动视图 切换标签状态
    /// - Parameters:
    ///   - contentView: 当前视图
    ///   - progress: 滑动偏移比例
    ///   - sourceIndex: 滑动前Index
    ///   - targetIndex: 滑动后Index
    func pageContentView(_ contentView : PageContentView , progress : CGFloat, sourceIndex : Int ,targetIndex : Int)
}
//Cell 标识符
private var ContentCellID = "Cell"

class PageContentView: UIView {
    //MARK: -定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX :CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?

    //MARK: -懒加载
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //隐藏滚动指示器
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK: -自定义构造函数
    init(frame:CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        //设置UI
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -创建UI界面
extension PageContentView{
    fileprivate func initSubviews(){
        //1. 将所有子控制器添加父控制器中
        for childvc in childVcs {
            parentViewController?.addChild(childvc)
        }
        //2. 添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
//MARK: -遵守协议 UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2. cell清空视图
        for view in cell.contentView.subviews{
            view .removeFromSuperview()
        }
        
        //3. 给Cell添加内容
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
//MARK: -遵守协议 UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //定义需要用到的 属性
        var progress : CGFloat = 0
        //旧的index
        var sourceIndex : Int = 0
        //新的index
        var targetIndex : Int = 0
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        
        let scrollviewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX{//左滑
            //计算 progress
            progress = currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW)
            
            //计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollviewW)
            
            //计算 targetIndex
            targetIndex = sourceIndex + 1
            
            if  targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果完全划过去
            if  currentOffsetX - startOffsetX == scrollviewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //计算 progress
            progress = 1 - (currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW))
            
            //计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollviewW)
            
            //计算 sourceIndex
            sourceIndex = targetIndex + 1
            
            if  sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }

        }
        print("startOffsetX->\(startOffsetX)currentOffsetX->\(currentOffsetX)")
        print("progress->\(progress)sourceIndex->\(sourceIndex)targetIndex->\(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: -对外暴露的方法
extension PageContentView{
    func setCurrentPageIndex(currentIndex:Int){
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        
        //更新collectionView 偏移位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
