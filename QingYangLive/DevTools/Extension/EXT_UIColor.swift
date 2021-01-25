//
//  EXT_UIColor.swift
//  QingYangLive
//
//  Created by 张华 on 2020/12/29.
//
import UIKit
extension UIColor{
    //16进制 赋值
    public convenience init(hexadecimal:String) {
        let cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
    }
    //全局主题色
    public static func MainColor() -> UIColor{
        return UIColor.white
    }
    //全局按钮主背景色
    public static func btnMainColor() -> UIColor{
        return UIColor.init(hexadecimal: "FF7D00")
    }
    //全局按钮辅背景色
    public static func btnAssistColor() -> UIColor{
        return UIColor.init(hexadecimal: "CAA064")
    }
    //全局主题色
    public static func AppMainColor() -> UIColor{
        return UIColor.init(hexadecimal: "f4f5f6")
    }
    //全局主题色_红
    public static func AppMainColor_red() -> UIColor{
        return UIColor.init(hexadecimal: "F02717")
    }
    //全局主题色_蓝
    public static func AppMainColor_blue() -> UIColor{
        return UIColor.init(hexadecimal: "3C90D2")
    }
    //全局主题色_灰
    public static func NavColor_gray() -> UIColor{
        return UIColor.init(hexadecimal: "a9a9a9")
    }
    //导航主题色_橙
    public static func NavColor_orange() -> UIColor{
        return UIColor.init(hexadecimal: "ff7d00")
    }
    //导航主题色_黑
    public static func NavColor_black() -> UIColor{
        return UIColor.init(hexadecimal: "423a35")
    }
    //全局字体默认色
    public static func MainTitleColor() -> UIColor{
        return UIColor.init(hexadecimal: "212121")
    }
    //全局字体默认色
    public static func MainSelectedTitleColor() -> UIColor{
        return UIColor.init(hexadecimal: "ff7d00")
    }
    //全局字体辅助色
    public static func MainPlaceholderColor() -> UIColor{
        return UIColor.init(hexadecimal: "757575")
    }
}
