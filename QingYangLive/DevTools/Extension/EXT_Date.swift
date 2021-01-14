//
//  EXT_Date.swift
//  QingYangLive
//
//  Created by 张华 on 2021/1/11.
//

import Foundation
extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
