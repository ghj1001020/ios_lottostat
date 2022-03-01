//
//  LottoScript.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import Foundation

class LottoScript {
    
}

extension Array where Element==Int {
    
    // 일치하는 숫자 갯수
    func getMatchCount(other: [Int]) -> Int {
        var count = 0
        for item in other {
            if( self.contains(item) ) {
                count += 1
            }
        }
        return count
    }
    
    // 연속하는 갯수
    mutating func getConsecutiveCount() -> Int {
        self.sort()
        
        var count = 0
        var tempCount = 0
        var temp = -1
        for item in self {
            // 두수 사이 간격이 1이면 이전번호와 연속된 수
            if( abs(temp-item) <= 1 ) {
                tempCount += 1
                if( tempCount > count ) {
                    count = tempCount
                }
            }
            else {
                if( tempCount > count ) {
                    count = tempCount
                }
                tempCount = 0
            }
            temp = item
        }
        return count
    }
}
