//
//  QYRecommendHeaderView.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/5.
//

import UIKit
import Kingfisher

class QYRecommendHeaderView: UICollectionReusableView {
    //MARK: -- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var model : QYRecommendationListModel?{
        didSet{
            // 0.校验模型是否有值
            guard let model = model else { return }
            
            // 2.昵称的显示
            iconImageView.image = UIImage.init(named: model.image_name)
            
            // 2.昵称的显示
            titleLabel.text = model.title
        }
    }
    
    @IBAction func moreClick(_ sender: Any) {
        
    }
    
}
