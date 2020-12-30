//
//  EXT_NSString.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/30.
//

import UIKit
extension String{
    /// 获取字符串 宽度
    /// - Parameter font: 字体大小
    /// - Returns: 字符串宽度
    public  func getStringWidth(font:UIFont,constrainedSize:CGSize,
                                option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin) -> CGRect {
        let attr = [NSAttributedString.Key.font:font]
        let rect = self.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
        
        return rect
    }
}
