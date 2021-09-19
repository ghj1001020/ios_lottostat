//
//  StringUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/16.
//

import Foundation

extension Optional where Wrapped == String {
    
    // null check, to string
    public func nullToString( defaultValue : String = "" ) -> String {
        var value : String = ""
        if( self == nil ) {
            value = defaultValue
        }
        else {
            value = self!
        }
        
        return value
    }
}

extension String {
    // substring(start, end) - 사용 : string[start...end]
    subscript( bounds: CountableClosedRange<Int> ) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    // substring(start, end)
    func substring(from: Int, to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(start, offsetBy: to-from)
        return String(self[start..<end])
    }
}
