//
//  DefineCode.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/20.
//

import Foundation

class DefineDefaults {
    public static let VERSION_COPY_SQLITE = "dfts_version_copy_sqlite"
}

// 필터 DEFAULTS 키
struct FILTER_KEY {
    // 이전 당첨번호 n개 이상 일치시 제외
    static let IS_EXCLUDE_PREV_WIN_NUMBER = "dfts_is_exclude_prev_win_number"
    static let CNT_EXCLUDE_PREV_WIN_NUMBER = "dfts_cnt_exclude_prev_win_number"
    static let IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS = "dfts_is_exclude_prev_win_number_with_bonus"
    static let DFT_IS_EXCLUDE_PREV_WIN_NUMBER = true
    static let DFT_CNT_EXCLUDE_PREV_WIN_NUMBER : Int = 4
    static let DFT_IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS = true
    
    // 이전 회차 번호 중 n개 이상 포함
    static let IS_INCLUDE_LAST_ROUND_WIN_NUMBER = "dfts_is_include_last_round_win_number"
    static let CNT_INCLUDE_LAST_ROUND_WIN_NUMBER = "dfts_cnt_include_last_win_number"
    static let IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS = "dfts_is_include_last_round_win_number_with_bonus"
    static let DFT_IS_INCLUDE_LAST_ROUND_WIN_NUMBER = true
    static let DFT_CNT_INCLUDE_LAST_ROUND_WIN_NUMBER : Int = 1
    static let DFT_IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS = true
    
    // n개 이상 연속된 수 제외
    static let IS_EXCLUDE_CONSECUTIVE_NUMBER = "dfts_is_exclude_consecutive_number"
    static let CNT_EXCLUDE_CONSECUTIVE_NUMBER = "dfts_cnt_exclude_consecutive_number"
    static let DFT_IS_EXCLUDE_CONSECUTIVE_NUMBER = true
    static let DFT_CNT_EXCLUDE_CONSECUTIVE_NUMBER : Int = 2
    
}
