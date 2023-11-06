//
//  HJError.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/14.
//

import Foundation

struct HJError : Error {
    
    public let msg : String
    
    init(_ msg: String) {
        self.msg = msg
    }
}
