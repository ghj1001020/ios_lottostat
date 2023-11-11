//
//  WidgetSQLiteService.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2023/11/11.
//

import Foundation
import SQLite3

class SQLiteService {
    // 마지막 로또번호 회차
    private static let SELECT_MAX_NO = "SELECT MAX(NO) " +
                                      "FROM LOTTO_WIN_NUMBER"
    
    // 해당 회차 로또당첨번호 조회
    public static let SELECT_ROUND_WIN_NUMBER = "SELECT WIN1, WIN2, WIN3, WIN4, WIN5, WIN6, BONUS " +
                                                "FROM   LOTTO_WIN_NUMBER " +
                                                "WHERE  NO=?"
    
    // 마지막 로또번호 회차
    public static func selectMaxNo() -> Int {
        var result = 0
        
        SQLite.shared.open()
        SQLite.shared.select(sql: SELECT_MAX_NO) { (stmt: OpaquePointer?) in
            if sqlite3_step(stmt) == SQLITE_ROW {
                result = Int(sqlite3_column_int(stmt, 0))
            }
        }
        SQLite.shared.close()
        
        return result
    }
    
    // 특정 회차 로또당첨번호 조회
    public static func selectRoundWinNumber(round: Int) -> [Int] {
        var list : [Int] = []

        SQLite.shared.open()
        SQLite.shared.select(sql: SELECT_ROUND_WIN_NUMBER, params: [round]) { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                list.append( Int(sqlite3_column_int(stmt, 0)) )
                list.append( Int(sqlite3_column_int(stmt, 1)) )
                list.append( Int(sqlite3_column_int(stmt, 2)) )
                list.append( Int(sqlite3_column_int(stmt, 3)) )
                list.append( Int(sqlite3_column_int(stmt, 4)) )
                list.append( Int(sqlite3_column_int(stmt, 5)) )
                list.append( Int(sqlite3_column_int(stmt, 6)) )
            }
        }
        SQLite.shared.close()
        
        return list
    }
}
