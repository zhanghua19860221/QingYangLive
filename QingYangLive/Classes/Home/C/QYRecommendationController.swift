//
//  QYRecommendationController.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/30.
//

import UIKit
//MARK: - 全局变量
private let kItemMargin : CGFloat = 10
private let kItemWidth  : CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemHeight : CGFloat = kItemWidth*3 / 4

private let kNormalCell : String = "Normal"
private let kYanZhiCell : String = "YanZhi"
private let kSectionHeader : String = "SectionHeader"

private let kHeaderH : CGFloat = 50

class QYRecommendationController: QYBaseViewController {
    //MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        //2、创建 UICollectionView
        let collectionFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kTabBarHeight - kNavHeight())
        let collectionView = UICollectionView(frame:collectionFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.AppMainColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kYanZhiCell)
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kSectionHeader)
        collectionView.register(UINib(nibName: "QYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeader)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        initSubviews()
        
    }
}

//MARK: - 设置UI界面
extension QYRecommendationController{
    private func initSubviews(){
        self.view.addSubview(collectionView)
    }
}

extension QYRecommendationController :UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  section == 0{
            return 8
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath)
        cell.backgroundColor = UIColor.red;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出Section headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeader, for: indexPath)
        headerView.backgroundColor = UIColor.AppMainColor()
        return  headerView
    }
}

extension QYRecommendationController :UICollectionViewDelegate{
    
    
    
}
