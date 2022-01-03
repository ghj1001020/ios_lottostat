//
//  MyLottoNumber.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/31.
//

import Foundation
import UIKit

enum MyLottoType {
    case SECT_OPEN
    case SECT_CLOSE
    case DATE
    case LOTTO
}

class MyLottoNumber {
    
    var type : MyLottoType
    let no : Int
    
    var mLottoList : [MyLottoData] = []

    
    init(_ no: Int, _ isOpen: Bool) {
        self.type = isOpen ? .SECT_OPEN : .SECT_CLOSE
        self.no = no
    }
}

// My 로또데이터
struct MyLottoData {
    let type : MyLottoType
    
    let regDate : String
    let numnber1 : Int
    let numnber2 : Int
    let numnber3 : Int
    let numnber4 : Int
    let numnber5 : Int
    let numnber6 : Int
    

    init(_ type: MyLottoType, _ date: String) {
        self.init(type, date, 0, 0, 0, 0, 0, 0)
    }
    
    init(_ type: MyLottoType, _ date: String, _ num1: Int, _ num2: Int, _ num3: Int, _ num4: Int, _ num5: Int, _ num6: Int) {
        self.type = type
        self.regDate = date
        self.numnber1 = num1
        self.numnber2 = num2
        self.numnber3 = num3
        self.numnber4 = num4
        self.numnber5 = num5
        self.numnber6 = num6
    }
}
