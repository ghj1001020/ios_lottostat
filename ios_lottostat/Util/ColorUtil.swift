//
//  ColorUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/19.
//

import Foundation
import UIKit

class ColorUtil {
    static func main() -> UIColor {
        return colorByString(rgb: "#00AF91")
    }
    static func mainSecond() -> UIColor {
        return colorByString(rgb: "#007965")
    }
    static func pressed() -> UIColor {
        return colorByString(rgb: "#D3D3D3")
    }
    static func orange() -> UIColor {
        return colorByString(rgb: "#F58634")
    }
    static func yellow() -> UIColor {
        return colorByString(rgb: "#FFCC29")
    }
    static func text() -> UIColor {
        return colorByString(rgb: "#000000")
    }
    
    
    // hex int -> UIColor 로 변환
    static func colorByHex(hex:Int , alpha:Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(alpha))
    }
    
    // rgb string -> UIColor 로 변환
    static func colorByString(rgb:String, alpha:Float = 1.0) -> UIColor {
        var _rgb = rgb.uppercased()
        if _rgb.hasPrefix("#") {
            _rgb = _rgb.replacingOccurrences(of: "#", with: "")
        }
        
        // string -> hex int
        var hexValue:UInt64 = 0
        Scanner(string: _rgb).scanHexInt64(&hexValue)

        if _rgb.count == 6 {
            let _red = CGFloat( (hexValue & 0xff0000) >> 16 ) / 255
            let _green = CGFloat( (hexValue & 0x00ff00) >> 8 ) / 255
            let _blue = CGFloat( (hexValue & 0x0000ff) ) / 255
            return UIColor(red: _red, green: _green, blue: _blue, alpha: CGFloat(alpha))
        }
        else {
            return UIColor()
        }
    }
}