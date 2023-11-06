//
//  DateUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/14.
//

import Foundation

class DateUtil {
    
}

extension String {
    // date string을 from format -> to format 으로 변환
    func convertDateFormat(_ fromFormat: String, _ toFormat: String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        
        guard let date : Date = formatter.date(from: self) else {
            return ""
        }
        
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
    
    // date string 변환
    func convertSeparator(_ sep1: String="-", _ sep2: String=":") -> String {
        switch self.count {
        case 8:
            return "\(self.substring(from: 0, to: 4))\(sep1)\(self.substring(from: 4, to: 6))\(sep1)\(self.substring(from: 6, to: 8))"  // yyyyMMdd

        case 12:
            return "\(self.substring(from: 0, to: 4))\(sep1)\(self.substring(from: 4, to: 6))\(sep1)\(self.substring(from: 6, to: 8)) \(self.substring(from: 8, to: 10))\(sep2)\(self.substring(from: 10, to: 12))" //yyyyMMddHHmm

        case 14:
            return "\(self.substring(from: 0, to: 4))\(sep1)\(self.substring(from: 4, to: 6))\(sep1)\(self.substring(from: 6, to: 8)) \(self.substring(from: 8, to: 10))\(sep2)\(self.substring(from: 10, to: 12))\(sep2)\(self.substring(from: 12, to: 14))"   // yyyyMMddHHmmss
            
        default:
            return self
        }
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
