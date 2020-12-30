//
//  PageContentView.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/30.
//

import UIKit
//Cell 标识符
private var ContentCellID = "Cell"

class PageContentView: UIView {
    //MARK: -创建属性
    private var childVcs:[UIViewController]
    private var parentViewController:UIViewController?
    
    //MARK: -懒加载
    private lazy var collectionView:UICollectionView = {[weak self] in
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        //隐藏滚动指示器
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    //MARK: -自定义构造函数
    init(frame:CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //1. 设置UI
        initSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -创建UI界面
extension PageContentView{
    private func initSubviews(){
        //1. 将所有子控制器添加父控制器中
        for childvc in childVcs {
            parentViewController?.addChild(childvc)
        }
        //2. 添加scrollView
        collectionView.frame = bounds
        addSubview(collectionView)
        
    }
}
//MARK: -遵守UICollectionView DataSource协议
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
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
