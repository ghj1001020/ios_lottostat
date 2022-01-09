//
//  DateUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/14.
//

import Foundation

class DateUtil {
    
    // date string을 from format -> to format 으로 변환
    static func convertDateFormat(_ date: String, _ fromFormat: String, _ toFormat: String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        
        guard let date : Date = formatter.date(from: date) else {
            return ""
        }
        
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
}

extension Date {
    
    // 1970.01.01 이후의 시간 밀리초
    func toMilliSeconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    // Date -> String 포맷
    func toString(_ format: String="yyyyMMdd") -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
