//
//  NumberUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/15.
//

import Foundation

extension Double {
    
    // 3자리마다 콤마넣기
    func addComma() -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: self)) ?? ""
    }
    
}
