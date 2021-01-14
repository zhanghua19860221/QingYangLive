//
//  QYRecommendationViewModel.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/11.
//

import UIKit

class QYRecommendationViewModel: QYBaseViewModel {
    // MARK:- 懒加载属性
    lazy var dataArray : [QYRecommendationListModel] = []
    //fileprivate lazy var dataArray  = [QYRecommendationListModel]()

}

// MARK:- 发送网络请求
extension QYRecommendationViewModel{
    
    func requestData(_ finishCallback : @escaping ()->()){
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        // 2.创建Group
        let dGroup = DispatchGroup()
        // 3.请求第一部分推荐数据
        dGroup.enter()
        QYNetwork.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 1. 将result 转换为字典
            guard let resulDict = result as?[String : AnyObject] else { return }
    
            // 2. 数据转模型
            guard let model = QYRecommendationListModel.deserialize(from: resulDict) else{ return }
            model.title = "推荐"
            model.image_name = "home_header_hot"
            // 3. 数据添加入数组
            self.dataArray.append(model)
            
            // 4. 离开组
            dGroup.leave()
        }
        
        // 4.请求第二部分颜值数据
        dGroup.enter()
        QYNetwork.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }

            // 2. 数据转模型
            guard let model = QYRecommendationListModel.deserialize(from: resultDict) else{ return }
            model.title = "颜值"
            model.image_name = "home_header_normal"
            // 3. 数据添加入数组
            self.dataArray.append(model)
            
            // 4. 离开组
            dGroup.leave()
        }
        
        //5.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            finishCallback()
        }
//
//        // 5.请求2-12部分游戏数据
//        dGroup.enter()
//        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
//        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
//            dGroup.leave()
//        }
//
//        // 6.所有的数据都请求到,之后进行排序
//        dGroup.notify(queue: DispatchQueue.main) {
//            self.anchorGroups.insert(self.prettyGroup, at: 0)
//            self.anchorGroups.insert(self.bigDataGroup, at: 0)
//
//            finishCallback()
//        }
        
    }
    
}
// MARK:- 获取默认数据
extension QYRecommendationViewModel{
    func getDefualtArray() -> [QYRecommendationListModel] {
        //分组 数组
        var  defaultListArray = NSMutableArray() as? [QYRecommendationListModel]
        //列表 数组
        var  defaultArray = NSMutableArray() as? [QYRecommendationModel]
        
        let  model = QYRecommendationModel()
        model.avatar_mid = "";
        model.avatar_small = "";
        model.owner_uid = 0;
        model.nickname = "";
        model.room_name = "";
        model.online = 0;
        model.room_name = "";
        defaultArray?.append(model)
        defaultArray?.append(model)
        defaultArray?.append(model)
        defaultArray?.append(model)
        
        let modelList0 = QYRecommendationListModel()
        modelList0.title = "推荐"
        modelList0.image_name = "home_header_hot"
        modelList0.data = defaultArray
        
        let modelList1 = QYRecommendationListModel()
        modelList1.title = "颜值"
        modelList1.image_name = "home_header_normal"
        modelList1.data = defaultArray

        defaultListArray?.append(modelList0)
        defaultListArray?.append(modelList1)
        
        return defaultListArray ?? [QYRecommendationListModel]()
    }
}
