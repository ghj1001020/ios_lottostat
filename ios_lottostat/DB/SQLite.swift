//
//  SQLite.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/20.
//

import Foundation
import SQLite3

class SQLite {

    // DB 버전 관리
    public static let DB_VERSION = 1
    // SQLite 파일 버전 관리
    public static let SQLite_VERSION = 1
    
    public static let DB_FILE_NAME = "lotto.db" // DB 파일명
    public static let DB_RESOURCE_FILE_NAME = "lotto"   // 리소스 DB 파일명
    public static let DB_RESOURCE_FILE_EXT = "db"   // 리소스 DB 파일확장자
    
    
    static let shared = SQLite()    // 싱글톤

    private var dbUrl : URL?
    private var dbPointer : OpaquePointer? = nil

    
    private init() {
        do {
//            self.dbUrl = Bundl    e.main.url(forResource: "lotto", withExtension: "db")?.appendingPathComponent("lotto")
            self.dbUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("lotto.db")
            let exists = FileManager.default.fileExists(atPath: self.dbUrl!.path)
            LogUtil.p("\(exists)")
            
            let path = Bundle.main.url(forResource: "lotto", withExtension: "db")
            
            try FileManager.default.copyItem(at: path!, to: dbUrl!)
            LogUtil.p("\(self.dbUrl?.absoluteString) , \(path)")
//            self.dbUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(DB_FILE_NAME)
        }
        catch {
            LogUtil.p(error.localizedDescription)
//            self.dbUrl = nil
        }
    }
    
    func open() {
        guard sqlite3_open(dbUrl?.path, &dbPointer) == SQLITE_OK else {
            LogUtil.p("SQLITE Open Failed")
            close()
            return
        }
    }
    
    func close() {
        sqlite3_close(dbPointer)
        dbPointer = nil
    }
    
    func execSQL( sql: String, params: [Any]=[] ) -> Bool {
        if( dbUrl == nil || dbPointer == nil ){
            LogUtil.p("dbUrl or dbPointer is nil")
            return false
        }
        
        var result = false
        var stmt : OpaquePointer?
        if sqlite3_prepare_v2(dbPointer, sql, -1, &stmt, nil) == SQLITE_OK  {
            let SQLITE_STATIC = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            for (index, item) in params.enumerated() {
                if( item is Int ) {
                    sqlite3_bind_int(stmt, Int32(index+1), Int32(item as! Int))
                }
                else if( item is Int32 ) {
                    sqlite3_bind_int(stmt, Int32(index+1), item as! Int32)
                }
                else if( item is Int64 ) {
                    sqlite3_bind_int64(stmt, Int32(index+1), item as! Int64)
                }
                else if( item is Double ) {
                    sqlite3_bind_double(stmt, Int32(index+1), item as! Double)
                }
                else {
                    let str = item as! String
                    sqlite3_bind_text(stmt, Int32(index+1), String(str.utf8), -1, SQLITE_STATIC)
                }
            }

            if sqlite3_step(stmt) == SQLITE_DONE  {
                result = true
            }
            else {
                result = false
                let errMsg = String(cString: sqlite3_errmsg(stmt))
                let errCode = Int(sqlite3_errcode(stmt))
                LogUtil.p("SQLITE_DONE failed. \(errMsg) \(errCode)")
            }
        }
        else {
            result = false
            let errMsg = String(cString: sqlite3_errmsg(stmt))
            LogUtil.p("sqlite3_prepare_v2 failed. \(errMsg)")
        }
        
        sqlite3_finalize(stmt)
        
        return result
    }
    
    func select(sql: String, params: [Any]=[], listener: (_ stmt: OpaquePointer?)->Void) {
        if( dbUrl == nil || dbPointer == nil ) {
            LogUtil.p("dbUrl or dbPointer is nil")
            return
        }

        var stmt : OpaquePointer?
        if sqlite3_prepare_v2(dbPointer, sql, -1, &stmt, nil) == SQLITE_OK {
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            for (index, item) in params.enumerated() {
                if( item is Int ) {
                    sqlite3_bind_int(stmt, Int32(index+1), Int32(item as! Int) )
                }
                else if( item is Int32 ) {
                    sqlite3_bind_int(stmt, Int32(index+1), item as! Int32)
                }
                else if( item is Int64 ) {
                    sqlite3_bind_int64(stmt, Int32(index+1), item as! Int64)
                }
                else if( item is Double ) {
                    sqlite3_bind_double(stmt, Int32(index+1), item as! Double)
                }
                else {
                    let str = item as! String
                    sqlite3_bind_text(stmt, Int32(index+1), String(str.utf8), -1, SQLITE_TRANSIENT)
                }
            }

            listener(stmt)
            sqlite3_finalize(stmt)
        }
        else {
            LogUtil.p(String(cString: sqlite3_errmsg(dbPointer)))
        }
    }

}
