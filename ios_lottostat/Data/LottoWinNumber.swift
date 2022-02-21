//
//  LottoWinNumber.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import Foundation

class LottoWinNumber {
    let no : Int
    let date : String
    let win1 : Int
    let win2 : Int
    let win3 : Int
    let win4 : Int
    let win5 : Int
    let win6 : Int
    let bonus : Int
    let place1Cnt : String
    let place1Amt : String
    let place2Cnt : String
    let place2Amt : String
    let place3Cnt : String
    let place3Amt : String
    let place4Cnt : String
    let place4Amt : String
    let place5Cnt : String
    let place5Amt : String
    
    init(_ no: Int, _ date: String, _ win1: Int, _ win2: Int, _ win3: Int, _ win4: Int, _ win5: Int, _ win6: Int, _ bonus: Int, _ place1Cnt: String, _ place1Amt: String, _ place2Cnt: String, _ place2Amt: String, _ place3Cnt: String, _ place3Amt: String, _ place4Cnt: String, _ place4Amt: String, _ place5Cnt: String, _ place5Amt: String) {
        self.no = no
        self.date = date
        self.win1 = win1
        self.win2 = win2
        self.win3 = win3
        self.win4 = win4
        self.win5 = win5
        self.win6 = win6
        self.bonus = bonus
        self.place1Cnt = place1Cnt
        self.place1Amt = place1Amt
        self.place2Cnt = place2Cnt
        self.place2Amt = place2Amt
        self.place3Cnt = place3Cnt
        self.place3Amt = place3Amt
        self.place4Cnt = place4Cnt
        self.place4Amt = place4Amt
        self.place5Cnt = place5Cnt
        self.place5Amt = place5Amt
    }
}
