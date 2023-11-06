//
//  HJLottoLabel.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/19.
//

import UIKit

class HJLottoLabel: HJLabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.size.height/2
        
        let num = StringUtil.convertToInt(text)
        if num > 0 {
            switch num {
            case 1...10:
                self.backgroundColor = ColorUtil.colorByString(rgb: "#fbc400")
                
            case 11...20:
                self.backgroundColor = ColorUtil.colorByString(rgb: "#69c8f2")
                
            case 21...30:
                self.backgroundColor = ColorUtil.colorByString(rgb: "#ff7272")
                
            case 31...40:
                self.backgroundColor = ColorUtil.colorByString(rgb: "#aaaaaa")

            case 41...45:
                self.backgroundColor = ColorUtil.colorByString(rgb: "#b0d840")

            default:
                break
            }
        }

    }
}
