//
//  LottoWinNumber.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import Foundation

class LottoWinNumber {
    let no : Int
    let win1 : Int
    let win2 : Int
    let win3 : Int
    let win4 : Int
    let win5 : Int
    let win6 : Int
    let bonus : Int
    
    init(_ no: Int, _ win1: Int, _ win2: Int, _ win3: Int, _ win4: Int, _ win5: Int, _ win6: Int, _ bonus: Int) {
        self.no = no
        self.win1 = win1
        self.win2 = win2
        self.win3 = win3
        self.win4 = win4
        self.win5 = win5
        self.win6 = win6
        self.bonus = bonus
    }
}
