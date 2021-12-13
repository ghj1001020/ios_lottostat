//
//  DefineQuery.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/21.
//

import Foundation

class DefineQuery {
    
    // 로또당첨번호 목록 조회
    public static let SELECT_LOTTO_WIN_NUMBER = "SELECT NO, WIN1, WIN2, WIN3, WIN4, WIN5, WIN6, BONUS " +
                                                "FROM   LOTTO_WIN_NUMBER"
    
    // 마지막 회차 로또당첨번호 조회
    public static let SELECT_LAST_ROUND_WIN_NUMBER = "SELECT   WIN1, WIN2, WIN3, WIN4, WIN5, WIN6, BONUS " +
                                                     "FROM     LOTTO_WIN_NUMBER " +
                                                     "ORDER BY NO DESC "          +
                                                     "LIMIT    1"
    
    // 해당 번호가 포함된 당첨번호 조회
    public static let SELECT_PREV_WIN_NUMBER_BY_NUM = "SELECT WIN1, WIN2, WIN3, WIN4, WIN5, WIN6, BONUS " +
                                                      "FROM   LOTTO_WIN_NUMBER " +
                                                       "WHERE  WIN1=? OR WIN2=? OR WIN3=? OR WIN4=? OR WIN5=? OR WIN6=?"
    
    // 해당 번호가 포함된 당첨번호 조회 (보너스 포함)
    public static let SELECT_PREV_WIN_NUMBER_BY_NUM_WITH_BONUS = "SELECT WIN1, WIN2, WIN3, WIN4, WIN5, WIN6, BONUS " +
                                                                 "FROM   LOTTO_WIN_NUMBER " +
                                                                 "WHERE  WIN1=? OR WIN2=? OR WIN3=? OR WIN4=? OR WIN5=? OR WIN6=? OR BONUS=?"
}
