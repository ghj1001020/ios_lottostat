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
    public static func selectPrevWinNumberByNum(num: Int, isBonus: Bool) -> [[Int]] {
        var result : [[Int]] = []
        var query : String = DefineQuery.SELECT_PREV_WIN_NUMBER_BY_NUM
        var param = [num, num, num, num, num, num]

        if( isBonus ) {
            query = DefineQuery.SELECT_PREV_WIN_NUMBER_BY_NUM_WITH_BONUS
            param.append(num)
        }
        
        SQLite.shared.open()
        SQLite.shared.select(sql: query, params: param) { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                var arrNum : [Int] = []
                arrNum.append( Int(sqlite3_column_int(stmt, 0)) )
                arrNum.append( Int(sqlite3_column_int(stmt, 1)) )
                arrNum.append( Int(sqlite3_column_int(stmt, 2)) )
                arrNum.append( Int(sqlite3_column_int(stmt, 3)) )
                arrNum.append( Int(sqlite3_column_int(stmt, 4)) )
                arrNum.append( Int(sqlite3_column_int(stmt, 5)) )
                if isBonus {
                    arrNum.append( Int(sqlite3_column_int(stmt, 6)) )
                }
                
                result.append(arrNum)
            }
        }
        SQLite.shared.close()
        
        return result
    }
    
    // 마지막 로또번호 회차
    public static func selectMaxNo() -> Int {
        var result = 0
        
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_MAX_NO) { (stmt: OpaquePointer?) in
            if sqlite3_step(stmt) == SQLITE_ROW {
                result = Int(sqlite3_column_int(stmt, 0))
            }
        }
        SQLite.shared.close()
        
        return result
    }
    
    
    // 테이블 생성
    public static func createTable() -> Bool {
        SQLite.shared.open()
        // My로또 테이블
        _ = SQLite.shared.execSQL(sql: DefineQuery.DROP_MY_LOTTO_TABLE)
        let tbl1 = SQLite.shared.execSQL(sql: DefineQuery.CREATE_MY_LOTTO_TABLE)
        SQLite.shared.close()
        
        return tbl1
    }
}
