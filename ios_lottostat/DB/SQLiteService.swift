//
//  SQLiteService.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import Foundation

class SQLiteService {
    
    // 로또당첨번호 가져오기
    public static func selectLottoWinNumber() {
        
        SQLite.shared.open()
        SQLite.shared.select(sql: DefineQuery.SELECT_LOTTO_WIN_NUMBER, listener: { (stmt: OpaquePointer?) in

        })
        SQLite.shared.close()
    }
}
