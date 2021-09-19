//
//  LogUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/16.
//

import Foundation


class LogUtil {
    
    private static let MAX_MSG = 1500
    
    
    static func p(_ _message : String? , _file: String=#file, _function: String=#function, _line: Int=#line, _column: Int=#column )
    {
        if( AppConfig.LOG_BLOCK ) {
            return
        }
        
        // 헤더
        var fileName = ""
        if let index = _file.lastIndex(of: "/") {
            fileName = String(_file[_file.index(index, offsetBy: 1)..<_file.endIndex])
        }
        let head : String = "[\(fileName) > \(_function) Line:\(_line)] >> "

        let message : String = _message.nullToString(defaultValue: "")
        // 글자수 제한
        let length : Int = message.count/MAX_MSG + 1
        for idx in 0..<length {
            // 바디
            let lastIdx = (idx+1)*MAX_MSG > message.count ? message.count : (idx+1)*MAX_MSG
            let body : String = message.substring(from: idx*MAX_MSG, to: lastIdx)
            print( "\(head)\(body)" )
        }
    }
}
