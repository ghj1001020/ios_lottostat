//
//  SQLiteService.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import Foundation
import SQLite3

class SQLiteService {
    
    // 로또당첨번호 가져오기
    public static func selectLottoWinNumber() -> [LottoWinNumber] {
        var list : [LottoWinNumber] = []
        
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_LOTTO_WIN_NUMBER, listener: { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                let no : Int = Int(sqlite3_column_int(stmt, 0))
                let win1 : Int = Int(sqlite3_column_int(stmt, 1))
                let win2 : Int = Int(sqlite3_column_int(stmt, 2))
                let win3 : Int = Int(sqlite3_column_int(stmt, 3))
                let win4 : Int = Int(sqlite3_column_int(stmt, 4))
                let win5 : Int = Int(sqlite3_column_int(stmt, 5))
                let win6 : Int = Int(sqlite3_column_int(stmt, 6))
                let bonus : Int = Int(sqlite3_column_int(stmt, 7))
                list.append( LottoWinNumber(no, win1, win2, win3, win4, win5, win6, bonus) )
            }
        })
        SQLite.shared.close()
        
        return list
    }
    
    // 마지막 로또번호 조회
    public static func selectLastRoundWinNumber(isBonus: Bool) -> [Int] {
        var result : [Int] = []
        
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_LAST_ROUND_WIN_NUMBER) { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                result.append( Int(sqlite3_column_int(stmt, 0)) )
                result.append( Int(sqlite3_column_int(stmt, 1)) )
                result.append( Int(sqlite3_column_int(stmt, 2)) )
                result.append( Int(sqlite3_column_int(stmt, 3)) )
                result.append( Int(sqlite3_column_int(stmt, 4)) )
                result.append( Int(sqlite3_column_int(stmt, 5)) )
                
                if( isBonus ) {
                    result.append( Int(sqlite3_column_int(stmt, 6)) )
                }
            }
        }
        SQLite.shared.close()
        
        return result
    }
    
    // 해당 번호가 포함된 당첨번호 조회
    public static func selectPrevWinNumberByNum(num: Int, isBonus: Bool) -> [Int] {
        var result : [Int] = []
        
        SQLite.shared.open()
        
        SQLite.shared.close()
        
        return result
    }
}
