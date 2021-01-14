//
//  QYCollectionPrettyCell.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/5.
//

import UIKit

class QYCollectionPrettyCell: UICollectionViewCell {
    @IBOutlet weak var online_numL: UILabel!
    @IBOutlet weak var name_L: UILabel!
    @IBOutlet weak var address_L: UILabel!
    @IBOutlet weak var icon_imageV: UIImageView!
    
    var model : QYRecommendationModel?{
        didSet{
            name_L.text = model?.nickname;
            online_numL.text = String(model?.online ?? 0);
            address_L.text = model?.room_name
            guard let iconURL = URL(string: model?.vertical_src ?? "") else { return }
            icon_imageV.kf.setImage(with: iconURL)
        }
    }
}
