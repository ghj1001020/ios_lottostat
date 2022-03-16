//
//  StringUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/16.
//

import Foundation

class StringUtil {
    
    // string -> int
    static func convertToInt(_ str: String?) -> Int {
        guard let str = str else {
            return 0
        }
        
        if str.isEmpty {
            return 0
        }
        
        return Int(str) ?? 0
    }
}

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
    
    // string -> int
    public mutating func toInt() -> Int {
        do {
            try self.toNumber()
            
            let number = Int(self!)
            if number != nil {
                return number!
            }
            else {
                throw HJError("parsing fail")
            }
        }
        catch let error as HJError {
            LogUtil.p(error.msg)
            return 0
        }
        catch {
            LogUtil.p(error.localizedDescription)
            return 0
        }
    }
    
    // string -> double
    public mutating func toDouble() -> Double {
        do {
            try self.toNumber()

            let number = Double(self!)
            if number != nil {
                return number!
            }
            else {
                throw HJError("parsing fail")
            }
        }
        catch let error as HJError {
            LogUtil.p(error.msg)
            return 0
        }
        catch {
            LogUtil.p(error.localizedDescription)
            return 0
        }
    }
    
    // string -> 숫자형태 string
    private mutating func toNumber() throws {
        if( self==nil || self!.isEmpty ) {
            throw HJError("string is nil or empty")
        }
        
        var sign = ""
        // 음수
        if( self!.starts(with: "-") ) {
            sign = "-"
        }
        
        // 정수
        let arrPoint = self!.split(separator: ".")
        let _integer = arrPoint[0].replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        // 소수
        var _decimal = ""
        if( arrPoint.count > 1 ) {
            _decimal = arrPoint[1].replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        }
        
        var _this = sign + _integer
        if !_decimal.isEmpty {
            _this += ".\(_decimal)"
        }
        
        self = _this
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
