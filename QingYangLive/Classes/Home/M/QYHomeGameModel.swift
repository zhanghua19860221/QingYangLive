//
//  QYHomeGameModel.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/14.
//

import UIKit

class QYHomeGameModel: QYBaseModel {
    var error : Int  = 0
    var msg : String  = ""
    var data : QYGameListModel?
    var redirectUrl : String  = ""
}

class QYGameListModel: QYBaseModel {
    var list :[QYGameModel]?
}

class QYGameModel: QYBaseModel {
    var type : Int = 0
    var seqId : Int = 0
    var schemeUrl : String = ""
    var bkUrl : String = ""
    var videoPostInfo : QYVideoPostInfoModel?
}

class QYVideoPostInfoModel: QYBaseModel {
    var postId : Int = 0
    var gameId : Int = 0
    var groupId : Int = 0
    var feedId : Int = 0
    var cover : String = ""
    var name : String = ""
    var cornerTag : String = ""
    var cornerColor : String = ""
    var average : String = ""
    var gameClass : String = ""
    var videoHash : String = ""
    var vid : Int = 0
    var isVertical : Int = 0
    var videoCover : String = ""
    var title : String = ""
    var viewCount : String = ""
    var duration : Int = 0
    var uicon : String = ""
    var uname : String = ""
    var isLive : Int = 0
    var uid : Int = 0
    var schemeUrl : String = ""
    var bkUrl : String = ""
    var comments : Int = 0
    var likes : Int = 0
    var liked : Int = 0
    var shareUrl : String = ""
    var prop : [String]?
}


