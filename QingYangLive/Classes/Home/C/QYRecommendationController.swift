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
private let kItemNormalHeight : CGFloat = kItemWidth * 3 / 4
private let kItemPrettyHeight : CGFloat = kItemWidth * 4 / 3

private let kNormalCell : String = "Normal"
private let kPrettyCell : String = "Pretty"
private let kSectionHeader : String = "SectionHeader"

private let kHeaderH : CGFloat = 50

class QYRecommendationController: QYBaseViewController {
    //MARK: - 懒加载
    fileprivate lazy var recommendVM = QYRecommendationViewModel()

    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemNormalHeight)
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
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kYanZhiCell)
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kSectionHeader)
        collectionView.register(UINib(nibName: "QYCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UINib(nibName: "QYCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCell)
        collectionView.register(UINib(nibName: "QYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeader)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        initSubviews()
        
        //获取网络数据
        initData()
    }

}

//MARK: - 设置UI界面
extension QYRecommendationController{
    private func initSubviews(){
        self.view.addSubview(collectionView)
    }
}

//MARK: - 数据请求
extension QYRecommendationController{
    private func initData(){
        //获取网络数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            
        }
    }
}



//MARK: - 代理 UICollectionViewDataSource
extension QYRecommendationController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model : QYRecommendationListModel =  recommendVM.dataArray[section]
        return model.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //定义 cell
        let model : QYRecommendationListModel =  recommendVM.dataArray[indexPath.section]
        //获取 cell
        if  indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! QYCollectionNormalCell
            cell.backgroundColor = UIColor.AppMainColor()
            cell.model = model.data?[indexPath.row]
            return cell

        }
        if  indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath) as! QYCollectionPrettyCell
            cell.backgroundColor = UIColor.AppMainColor()
            cell.model = model.data?[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出Section headerView
        let headerView : QYRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeader, for: indexPath) as! QYRecommendHeaderView
        let model : QYRecommendationListModel =  recommendVM.dataArray[indexPath.section]
        headerView.backgroundColor = UIColor.AppMainColor()
        headerView.titleLabel.text = model.title
        headerView.iconImageView.image = UIImage(named: model.image_name)
        return  headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  indexPath.section == 0{
            return CGSize(width: kItemWidth, height: kItemNormalHeight)
        }
        if  indexPath.section == 1{
            return CGSize(width: kItemWidth, height: kItemPrettyHeight)
        }
        return CGSize.zero
    }
}
//MARK: - 代理 UICollectionViewDelegate
extension QYRecommendationController :UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("当前点击 ->section->\(indexPath.section)->row->\(indexPath.row)")
    }
    
}
