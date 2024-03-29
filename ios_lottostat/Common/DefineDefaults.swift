//
//  DefineCode.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/20.
//

import Foundation

class DefineDefaults {
    public static let VERSION_COPY_SQLITE = "dfts_version_copy_sqlite"
    public static let DB_VERSION = "dfts_db_version"
}

// 필터 DEFAULTS 키
struct FILTER_KEY {
    // 이전 회차 번호 중 n개 이상 포함
    static let IS_INCLUDE_LAST_ROUND_WIN_NUMBER = "dfts_is_include_last_round_win_number"
    static let CNT_INCLUDE_LAST_ROUND_WIN_NUMBER = "dfts_cnt_include_last_win_number"
    static let IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS = "dfts_is_include_last_round_win_number_with_bonus"

    
    // n개 이상 연속된 수 제외
    static let IS_EXCLUDE_CONSECUTIVE_NUMBER = "dfts_is_exclude_consecutive_number"
    static let CNT_EXCLUDE_CONSECUTIVE_NUMBER = "dfts_cnt_exclude_consecutive_number"

    
}




struct LAST_ROUND_WIN_NUMBER {
    static let SELECT = "is_match_last_round_win_number"
}

struct CONSECUTIVE_NUMBER {
    static let SELECT = "is_consecutive_number"
}
