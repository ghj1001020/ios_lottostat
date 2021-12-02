//
//  PrefUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/20.
//

import Foundation

class DefaultsUtil {
    
    public static let shared = DefaultsUtil()
    
    private init() {}
    
    // 데이터 저장
    func put(_ key: String, _ value: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
    }
    
    func put(_ key: String, _ value: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
    }
    
    func put(_ key: String, _ value: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
    }
    
    // 데이터 조회
    func get(_ key: String, _ defaultValue: Int=0) -> Int {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: key) == nil {
            return defaultValue
        }
        return userDefaults.integer(forKey: key)
    }
    
    func get(_ key: String, _ defaultValue: String="") -> String {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key) ?? defaultValue
    }
    
    func get(_ key: String, _ defaultValue: Bool=false) -> Bool {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: key) == nil {
            return defaultValue
        }
        return userDefaults.bool(forKey: key)
    }
}
