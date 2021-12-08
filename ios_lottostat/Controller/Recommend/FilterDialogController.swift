//
//  FilterDialogController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/04.
//

import UIKit

class FilterDialogController: BaseBottomSheetContent {
    
    enum LAYOUT_TYPE {
        case LIST
        case INPUT_COUNT
    }
    
    enum FILTER_TYPE {
        case EXCLUDE_PREV_WIN_NUMBER
        case INCLUDE_LAST_ROUND_WIN_NUMBER
        case EXCLUDE_CONSECUTIVE_NUMBER
    }
    
    // 현재 화면타입
    var mLayoutType : LAYOUT_TYPE = .LIST
    // 선택한 필터타입
    var mFilterType : FILTER_TYPE = .EXCLUDE_PREV_WIN_NUMBER
 
    // 필터 레이아웃
    @IBOutlet var layoutFilterList: UIView! // 목록
    @IBOutlet var layoutInputCount: UIView! // 입력
    
    // 필터목록 버튼
    @IBOutlet var chkExcludePrevWinNumber: HJCheckBox!
    @IBOutlet var chkIncludeLastRoundWinNumber: HJCheckBox!
    @IBOutlet var chkExcludeConsecutiveNumber: HJCheckBox!
    
    
    // 이전 당첨번호 n개 이상 일치시 제외
    var isExcludePrevWinNumberWithBonus : Bool = true   // 보너스 포함여부
    
    // 이전 회차 번호 중 n개 이상 포함
    var isIncludeLastRoundWinNumberWithBonus : Bool = true  // 보너스 포함여부
    
    
    override func viewDidLoad() {
        LogUtil.p("FilterDialogController")
        
        // 필터목록 인덱스
        chkExcludePrevWinNumber.tag = 0
        chkIncludeLastRoundWinNumber.tag = 1
        chkExcludeConsecutiveNumber.tag = 2
    }
    
    
    // 닫기버튼 이벤트
    
    // 필터 목록화면 클릭 이벤트
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        cancelFilterSetting()
        if( mLayoutType != .LIST ) {
            mLayoutType = .LIST
            changeFilterLayout()
            return
        }
        bottomSheet?.hideBottomSheet()
    }
    
    // 필터 입력화면 클릭 이벤트
    
    
    // 필터 체크박스 선택변경 리스너
    @IBAction func onFilterCheckedChangeListener(_ sender: HJCheckBox) {
        // 이전 당첨번호 제외
        if sender.tag == 0 {
            sender.isChecked = !sender.isChecked
            if sender.isChecked {
                mFilterType = .EXCLUDE_PREV_WIN_NUMBER
                mLayoutType = .INPUT_COUNT
                
                changeFilterLayout()
                setInputCount(isBonusShow: true, isBonus: isExcludePrevWinNumberWithBonus)
            }
            else {
                DefaultsUtil.shared.put( DEFAULTS_FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER, false)
                chkExcludePrevWinNumber.setTitle(String(format: "이전 당첨번호와 %s개 이상 일치시 제외", "n"), for: .normal)
            }
        }
        // 이전 회차 번호 중 n개 이상 포함
        else if sender.tag == 1 {
            if sender.isChecked {
                mFilterType = .INCLUDE_LAST_ROUND_WIN_NUMBER
                mLayoutType = .INPUT_COUNT
                
                changeFilterLayout()
                setInputCount(isBonusShow: true, isBonus: isIncludeLastRoundWinNumberWithBonus)
            }
            else {
                DefaultsUtil.shared.put( DEFAULTS_FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER, false)
                chkIncludeLastRoundWinNumber.setTitle(String(format: "직전 회차 당첨번호 중 %s개 이상 포함", "n"), for: .normal)
            }
        }
        // n개 이상 연속된 수 제외
        else if sender.tag == 2 {
            if sender.isChecked {
                mFilterType = .EXCLUDE_CONSECUTIVE_NUMBER
                mLayoutType = .INPUT_COUNT
                
                changeFilterLayout()
                setInputCount(isBonusShow: false, isBonus: false)
            }
            else {
                DefaultsUtil.shared.put( DEFAULTS_FILTER_KEY.IS_EXCLUDE_CONSECUTIVE_NUMBER, false)
                chkExcludeConsecutiveNumber.setTitle(String(format: "%s개 이상 연속된 수 제외", "n"), for: .normal)
            }
        }
    }
    
    // 필터 설정 취소
    func cancelFilterSetting() {
        if( mLayoutType == .LIST ) {
            return
        }
        
        // 이전 당첨번호 제외
        if( mFilterType == .EXCLUDE_PREV_WIN_NUMBER ) {
            chkExcludePrevWinNumber.isChecked = false
        }
        // 이전 회차 번호 중 n개 이상 포함
        else if( mFilterType == .INCLUDE_LAST_ROUND_WIN_NUMBER ) {
            chkIncludeLastRoundWinNumber.isChecked = false
        }
        // n개 이상 연속된 수 제외
        else if( mFilterType == .EXCLUDE_CONSECUTIVE_NUMBER ) {
            chkExcludeConsecutiveNumber.isChecked = false
        }
    }
    
    // 필터화면 레이아웃 변경
    func changeFilterLayout() {
        if mLayoutType == .INPUT_COUNT {
            layoutFilterList.isHidden = true
            layoutInputCount.isHidden = false
        }
        else {
            layoutFilterList.isHidden = false
            layoutInputCount.isHidden = true
        }
    }
    
    // 횟수입력 레이아웃 설정
    func setInputCount(isBonusShow: Bool, isBonus: Bool) {
        
    }
}
