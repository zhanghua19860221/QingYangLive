//
//  QYNetwork.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/7.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
    case PUT
    case DELETE
    case HEAD
    case PATCH
}

class QYNetwork{
    //网络请求方法
    class func requestData(_ type : MethodType , URLString : String , parameters : [String : Any]? = nil , finishedCallback : @escaping (_ result : Any)->()){
        // 1.获取类型
        var method : HTTPMethod!
        switch  type{
        case .GET:
            method = HTTPMethod.get
        case .POST:
            method = HTTPMethod.post
        case .PUT:
            method = HTTPMethod.put
        case .DELETE:
            method = HTTPMethod.delete
        case .HEAD:
            method = HTTPMethod.head
        case .PATCH:
            method = HTTPMethod.patch
        }

        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: nil).responseJSON { (response) in
            // 3.获取结果
            let Header = response.response!.allHeaderFields
            print("请求头 ->\(Header)")
            
            let url = response.response!.url
            print("请求路径 ->\(String(describing: url))")

            let code = response.response!.statusCode
            print("请求类型 ->\(type) 状态码 ->\(code)")
            
            guard let result = (response.result.value as? [String : Any]) else {
                print("错误数据 ->\(response.result.error!)")
                return
            }
            let jsonStr = toJSONString(dict: result as NSDictionary)

            print("请求返回数据 ->\(jsonStr)")

            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
  
}

// 转换json 数据

func toJSONString(dict:NSDictionary?)->String{

    let data = try? JSONSerialization.data(withJSONObject: dict!, options: JSONSerialization.WritingOptions.prettyPrinted)
    
    let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    
    return strJson! as String

}
