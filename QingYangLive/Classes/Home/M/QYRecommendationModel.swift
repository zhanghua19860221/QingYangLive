//
//  QYRecommendationModel.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/11.
//

import UIKit

class QYRecommendationListModel: QYBaseModel {
    var  error : Bool = false
    var  title : String = "推荐"
    var  image_name : String = "home_header_phone"
    var  data : [QYRecommendationModel]?
}

class QYRecommendationModel: QYBaseModel {
    var  avatar_mid : String = ""
    var  avatar_small : String = ""
    var  cate_id : Int = 0
    var  room_id : Int = 0
    var  room_name : String = ""
    var  room_src : String = ""
    var  online : Int = 0
    var  owner_uid : Int = 0
    var  nickname : String = ""
    var  vertical_src : String = ""

}
