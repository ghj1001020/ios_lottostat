//
//  LottoScript.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import Foundation

class LottoScript {
    
    // 로또번호 생성
    // round-생성하는 로또회차, count-생성갯수
    public static func generateLottoNumberList(round: Int, count: Int) -> [[Int]] {
        var resultList = [[Int]]()

        let isLastRoundWinNumber = DefaultsUtil.shared.getBool(LAST_ROUND_WIN_NUMBER.SELECT, LAST_ROUND_WIN_NUMBER.DFT_SELECT)
        let cntLastRoundWinNumber = DefaultsUtil.shared.getInt(LAST_ROUND_WIN_NUMBER.CNT, LAST_ROUND_WIN_NUMBER.DFT_CNT)
        let isLastRoundWinNumberWithBonus = DefaultsUtil.shared.getBool(LAST_ROUND_WIN_NUMBER.BONUS, LAST_ROUND_WIN_NUMBER.DFT_BONUS)
        
        let isConsecutiveNumber = DefaultsUtil.shared.getBool(CONSECUTIVE_NUMBER.SELECT, CONSECUTIVE_NUMBER.DFT_SELECT)
        let cntConsecutiveNumber = DefaultsUtil.shared.getInt(CONSECUTIVE_NUMBER.CNT, CONSECUTIVE_NUMBER.DFT_CNT)
        
        var index = 0
        // count 개수만큼 당첨번호 생성
        while(index < count) {
            // 추천로또번호 생성
            var LOTTO = [Int]()
            // 로또번호 1~45
            var GROUP = DefineCode.LOTTERY.map({
                $0
            })

            // 이전 회차 번호 중 n개 일치
            if(isLastRoundWinNumber && round > 1) {
                var lastRound = SQLiteService.selectRoundWinNumber(round: round-1, isBonus: isLastRoundWinNumberWithBonus)
                // 0 <= idx < cntIncludeLastRoundWinNumber
                for _ in 0...cntLastRoundWinNumber {
                    // 인덱스 구해서 추천번호 뽑기
                    let tempIndex = Int( arc4random_uniform(UInt32(lastRound.count)) )
                    let goodNumber = lastRound[tempIndex]
                    LOTTO.append(goodNumber)
                    // 당첨번호에서 추가한 번호삭제
                    lastRound.remove(at: tempIndex)
                    if let _index = GROUP.firstIndex(of: goodNumber) {
                        GROUP.remove(at: _index)
                    }
                }
                // 나머지 당첨번호 삭제
                for num in lastRound {
                    if let _index = GROUP.firstIndex(of: num) {
                        GROUP.remove(at: _index)
                    }
                }
            }
            
            while( LOTTO.count < 6 ) {
                // n개 연속된수
                if( isConsecutiveNumber && cntConsecutiveNumber == (6-LOTTO.count) ) {
                    LOTTO.generateConsecutiveNumber(consecutive: cntConsecutiveNumber+1)
                }
                
                // 번호추천 결과담고 모그룹에서 삭제
                if( LOTTO.count < 6 ) {
                    let numIndex = Int( arc4random_uniform(UInt32(GROUP.count)) )
                    let number = GROUP[numIndex]
                    
                    LOTTO.append(number)
                    LOTTO.sort()
                    GROUP.remove(at: numIndex)
                }
            }
            
            // 번호 추천 목록에 담기
            resultList.append(LOTTO)
            
            // 인덱스 1추가
            index += 1
        }
        
        return resultList
    }
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
    
    // 연속수 구하기
    func getConsecutiveNumber(base: Int, direction: Int) -> Int {
        var number = base
        // 왼쪽
        if direction == 0 {
            repeat {
                number -= 1
            }
            while(self.contains(number))
        }
        // 오른쪽
        else {
            repeat {
                number += 1
            }
            while(self.contains(number))
        }
        return number
    }
    
    // 연속수 구하기
    mutating func generateConsecutiveNumber(consecutive: Int) {
        if self.count >= 6 || consecutive == 0 || consecutive <= self.getConsecutiveCount() {
            return
        }
        
        self.sort()
        
        // 기준수
        let numIndex = Int( arc4random_uniform(UInt32(self.count)) )
        let number = self[numIndex]
        var lNumber = 0, rNumber = 0
        
        while( self.getConsecutiveCount() < consecutive && self.count < 6 ) {
            lNumber = getConsecutiveNumber(base: number, direction: 0)
            rNumber = getConsecutiveNumber(base: number, direction: 1)
            
            let direction = Int( arc4random_uniform(UInt32(2)) )
            // 왼쪽선택
            if(direction == 0 && lNumber > 0) {
                self.append(lNumber)    // 왼쪽추가
                if(consecutive < self.getConsecutiveCount()) {
                    // 연속개수가 초과하면 지우고 오른쪽선택
                    if let _index = self.firstIndex(of: lNumber) {
                        self.remove(at: _index)
                    }
                    self.append(rNumber)
                }
            }
            else if(direction == 0 && lNumber <= 0 ) {
                self.append(rNumber)    // 무조건 오른쪽추가
            }
            // 오른쪽선택
            else if(direction == 1 && rNumber < 46) {
                self.append(rNumber)
                if(consecutive < self.getConsecutiveCount()) {
                    // 연속개수가 초과하면 지우고 왼쪽선택
                    if let _index = self.firstIndex(of: rNumber) {
                        self.remove(at: _index)
                    }
                    self.append(lNumber)
                }
            }
            else if(direction == 1 && rNumber >= 46) {
                self.append(lNumber)    // 무조건 왼쪽추가
            }
        }
    }
}
