//
//  QYCollectionNormalCell.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/5.
//

import UIKit

class QYCollectionNormalCell: UICollectionViewCell {
    @IBOutlet weak var nack_nameL: UILabel!
    @IBOutlet weak var online_numL: UILabel!
    @IBOutlet weak var title_nameL: UILabel!
    @IBOutlet weak var cover_imageV: UIImageView!
    
    var model : QYRecommendationModel?{
        didSet{
            nack_nameL.text = model?.nickname;
            online_numL.text = String(model?.online ?? 0);
            title_nameL.text = model?.room_name
            guard let iconURL = URL(string: model?.vertical_src ?? "") else { return }
            cover_imageV.kf.setImage(with: iconURL)
        }
    }
}
