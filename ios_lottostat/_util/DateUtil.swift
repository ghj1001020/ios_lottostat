//
//  DateUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/14.
//

import Foundation

extension Date {
    
    // 1970.01.01 이후의 시간 밀리초
    func toMilliSeconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
