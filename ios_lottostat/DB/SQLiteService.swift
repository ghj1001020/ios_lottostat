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
    
    // My로또 데이터 저장
    public static func insertMyLottoData(_ roundNo: Int, _ list: Array<[Int]>) {
        SQLite.shared.open()
        let date : String = Date().toString("yyyyMMddHHmmss")
        for lottoDatas in list {
            var params: [Any] = []
            params.insert(roundNo, at: 0)
            params.insert(date, at: 1)
            for data in lottoDatas {
                params.append(data)
            }
            
            _ = SQLite.shared.execSQL(sql: DefineQuery.INSERT_MY_LOTTO, params: params)
        }
        SQLite.shared.close()
    }
    
    // My로또 회차 데이터 조회
    public static func selectMyLottoRoundNo() -> [MyLottoNumber] {
        var list : [MyLottoNumber] = []
        
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_MY_LOTTO_ROUND) { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                let roundNo = Int(sqlite3_column_int(stmt, 0))
                list.append(MyLottoNumber(roundNo, false))
            }
        }
        SQLite.shared.close()
        
        // 첫번째 no 로또번호 조회
        if list.count > 0 {
            list[0].isOpen(true)
            list[0].mLottoList.removeAll()
            list[0].mLottoList = selectMyLottoData(list[0].no)
        }
        
        return list
    }
    
    // My로또 데이터 조회
    public static func selectMyLottoData(_ no: Int) -> [MyLottoData] {
        var list : [MyLottoData] = []
        
        var tempDate : String = ""
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_MY_LOTTO_NUMBER, params: [no]) { (stmt: OpaquePointer?) in
            while sqlite3_step(stmt) == SQLITE_ROW {
                let no = Int(sqlite3_column_int(stmt, 0))
                let date = String(cString: sqlite3_column_text(stmt, 1))
                let num1 = Int(sqlite3_column_int(stmt, 2))
                let num2 = Int(sqlite3_column_int(stmt, 3))
                let num3 = Int(sqlite3_column_int(stmt, 4))
                let num4 = Int(sqlite3_column_int(stmt, 5))
                let num5 = Int(sqlite3_column_int(stmt, 6))
                let num6 = Int(sqlite3_column_int(stmt, 7))
                
                if tempDate != date {
                    list.append(MyLottoData(.DATE, date))
                    tempDate = date
                }
                list.append(MyLottoData(.LOTTO, date, num1, num2, num3, num4, num5, num6))
            }
        }
        SQLite.shared.close()
        
        return list
    }
}
