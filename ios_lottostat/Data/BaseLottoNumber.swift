//
//  BaseLottoNumber.swift
//  ios_lottostat
//
//  Created by tsis001 on 2023/08/07.
//

import Foundation

class BaseLottoNumber {
    let win1 : Int
    let win2 : Int
    let win3 : Int
    let win4 : Int
    let win5 : Int
    let win6 : Int

    init(_ win1: Int, _ win2: Int, _ win3: Int, _ win4: Int, _ win5: Int, _ win6: Int) {
        self.win1 = win1;
        self.win2 = win2;
        self.win3 = win3;
        self.win4 = win4;
        self.win5 = win5;
        self.win6 = win6;
    }
}
