//
//  SimulationNumberData.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/13.
//

import Foundation

struct SimulationNumberData {
    let num1 : Int
    let num2 : Int
    let num3 : Int
    let num4 : Int
    let num5 : Int
    let num6 : Int
    let result : WIN_RATE
    
    init(_ num1: Int, _ num2: Int, _ num3: Int, _ num4: Int, _ num5: Int, _ num6: Int, _ result: WIN_RATE) {
        self.num1 = num1
        self.num2 = num2
        self.num3 = num3
        self.num4 = num4
        self.num5 = num5
        self.num6 = num6
        self.result = result
    }
}

enum WIN_RATE {
    case NONE
    case WIN1PLACE
    case WIN2PLACE
    case WIN3PLACE
    case WIN4PLACE
    case WIN5PLACE
}
