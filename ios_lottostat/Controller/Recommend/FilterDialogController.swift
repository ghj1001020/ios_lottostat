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
    
    // 필터입력 버튼
    @IBOutlet var tfCount: HJLottoNumberTextField!
    @IBOutlet var chkBonus: HJCheckBox!
    @IBOutlet var btnCountCancel: UIButton!
    @IBOutlet var btnCountOk: UIButton!
    @IBOutlet var btnCountMinus: UIButton!
    @IBOutlet var btnCountPlus: UIButton!
    @IBOutlet var lbDesc: HJLabel!
    @IBOutlet var lbCountTitle: UILabel!
    
    
    override func viewDidLoad() {
        
        // 버튼 인덱스
        chkExcludePrevWinNumber.tag = 0
        chkIncludeLastRoundWinNumber.tag = 1
        chkExcludeConsecutiveNumber.tag = 2
        btnCountCancel.tag = 100
        btnCountOk.tag = 101
        btnCountMinus.tag = 102
        btnCountPlus.tag = 103
        
        initLayout()
    }
    
    func initLayout() {
        // 필터목록
        // 이전 당첨번호 제외
        updateExcludePrevWinNumber()
        // 이전 회차 번호 중 1개 이상 포함
        updateIncludeLastRoundWinNumber()
        // n개 이상 연속된 수 제외
        updateExcludeConsecutiveNumber()
    }
    
    
    
    // 닫기 이벤트
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        cancelFilterSetting()
        dismissDialog()
    }
    
    // 필터 목록화면 체크박스 이벤트
    @IBAction func onFilterCheckedChangeListener(_ sender: HJCheckBox) {
        // 이전 당첨번호 제외
        if sender.tag == 0 {
            if sender.isChecked {
                mFilterType = .EXCLUDE_PREV_WIN_NUMBER
                mLayoutType = .INPUT_COUNT
                
                changeFilterLayout()
                setInputCount(isBonusShow: true, isBonus: DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS))
            }
            else {
                DefaultsUtil.shared.put( FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER, false)
                chkExcludePrevWinNumber.setTitle(String(format: "이전 당첨번호와 %@개 이상 일치시 제외", "n"), for: .normal)
            }
        }
        // 이전 회차 번호 중 n개 이상 포함
        else if sender.tag == 1 {
            if sender.isChecked {
                mFilterType = .INCLUDE_LAST_ROUND_WIN_NUMBER
                mLayoutType = .INPUT_COUNT
                
                changeFilterLayout()
                setInputCount(isBonusShow: true, isBonus: DefaultsUtil.shared.getBool(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER))
            }
            else {
                DefaultsUtil.shared.put( FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER, false)
                chkIncludeLastRoundWinNumber.setTitle(String(format: "직전 회차 당첨번호 중 %@개 이상 포함", "n"), for: .normal)
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
                DefaultsUtil.shared.put( FILTER_KEY.IS_EXCLUDE_CONSECUTIVE_NUMBER, false)
                chkExcludeConsecutiveNumber.setTitle(String(format: "%@개 이상 연속된 수 제외", "n"), for: .normal)
            }
        }
    }
    
    // 필터 입력화면 클릭 이벤트
    @IBAction func onFilterInputCountListener(_ sender: UIButton) {
        tfCount.resignFirstResponder()

        // 취소
        if sender.tag == 100 {
            onBackButtonClick(sender)
        }
        // 확인
        else if sender.tag == 101 {
            let cnt = StringUtil.convertToInt(tfCount.text)
            let isBonus = chkBonus.isChecked
            
            // 이전 당첨번호 제외
            if mFilterType == .EXCLUDE_PREV_WIN_NUMBER {
                DefaultsUtil.shared.put(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER, true)
                DefaultsUtil.shared.put(FILTER_KEY.CNT_EXCLUDE_PREV_WIN_NUMBER, cnt)
                DefaultsUtil.shared.put(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS, isBonus)
                updateExcludePrevWinNumber()
            }
            // 이전 회차 번호 중 n개 이상 포함
            else if mFilterType == .INCLUDE_LAST_ROUND_WIN_NUMBER {
                DefaultsUtil.shared.put(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER, true)
                DefaultsUtil.shared.put(FILTER_KEY.CNT_INCLUDE_LAST_ROUND_WIN_NUMBER, cnt)
                DefaultsUtil.shared.put(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS, isBonus)
                updateIncludeLastRoundWinNumber()
            }
            // n개 이상 연속된 수 제외
            else if mFilterType == .EXCLUDE_CONSECUTIVE_NUMBER {
                DefaultsUtil.shared.put(FILTER_KEY.IS_EXCLUDE_CONSECUTIVE_NUMBER, true)
                DefaultsUtil.shared.put(FILTER_KEY.CNT_EXCLUDE_CONSECUTIVE_NUMBER, cnt)
                updateExcludeConsecutiveNumber()
            }
            
            dismissDialog()
        }
        // 횟수입력 > 숫자 -
        else if sender.tag == 102 {
            tfCount.minus()
        }
        // 횟수입력 > 숫자 +
        else if sender.tag == 103 {
            tfCount.add()
        }
    }
    
    // 이전 당첨번호 n개 이상 일치시 제외
    func updateExcludePrevWinNumber() {
        let isExcludePrevWinNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER)
        let cntExcludePrevWinNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_PREV_WIN_NUMBER)
        let isExcludePrevWinNumberWithBonus = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS)
        
        chkExcludePrevWinNumber.isChecked = isExcludePrevWinNumber
        if isExcludePrevWinNumber {
            let strBonus = isExcludePrevWinNumberWithBonus ? "보너스 포함" : "보너스 미포함"
            chkExcludePrevWinNumber.setTitle(String(format: "이전 당첨번호와 %d개 이상 일치시 제외 (%@)", cntExcludePrevWinNumber, strBonus), for: .normal)
        }
        else {
            chkExcludePrevWinNumber.setTitle(String(format: "이전 당첨번호와 %@개 이상 일치시 제외", "n"), for: .normal)
        }
    }
    
    // 이전 회차 번호 중 n개 이상 포함
    func updateIncludeLastRoundWinNumber() {
        let isIncludeLastRoundWinNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER)
        let cntIncludeLastRoundWinNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_INCLUDE_LAST_ROUND_WIN_NUMBER)
        let isIncludeLastRoundWinNumberWithBonus = DefaultsUtil.shared.getBool(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS)
        
        chkIncludeLastRoundWinNumber.isChecked = isIncludeLastRoundWinNumber
        if isIncludeLastRoundWinNumber {
            let strBonus = isIncludeLastRoundWinNumberWithBonus ? "보너스 포함" : "보너스 미포함"
            chkIncludeLastRoundWinNumber.setTitle(String(format: "직전 회차 당첨번호 중 %d개 이상 포함 (%@)", cntIncludeLastRoundWinNumber, strBonus), for: .normal)
        }
        else {
            chkIncludeLastRoundWinNumber.setTitle(String(format: "직전 회차 당첨번호 중 %@개 이상 포함", "n"), for: .normal)
        }
    }
    
    // n개 이상 연속된 수 제외
    func updateExcludeConsecutiveNumber() {
        let isExcludeConsecutiveNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_CONSECUTIVE_NUMBER)
        let cntExcludeConsecutiveNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_CONSECUTIVE_NUMBER)
        
        chkExcludeConsecutiveNumber.isChecked = isExcludeConsecutiveNumber
        if isExcludeConsecutiveNumber {
            chkExcludeConsecutiveNumber.setTitle(String(format: "%d개 이상 연속된 수 제외", cntExcludeConsecutiveNumber), for: .normal)
        }
        else {
            chkExcludeConsecutiveNumber.setTitle(String(format: "%@개 이상 연속된 수 제외", "n"), for: .normal)
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
    
    // 다이얼로그 닫기
    func dismissDialog() {
        if( mLayoutType != .LIST ) {
            mLayoutType = .LIST
            changeFilterLayout()
            return
        }
        bottomSheet?.hideBottomSheet()
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
        switch mFilterType {
        case .EXCLUDE_PREV_WIN_NUMBER:
            tfCount.setMinNumber(num: 4)
            tfCount.setMaxNumber(num: 6)
            lbCountTitle.text = "이전 당첨번호와 n개 이상 일치시 제외"
            lbDesc.isHidden = true
            tfCount.setNumber(num: DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_PREV_WIN_NUMBER))
            
        case .INCLUDE_LAST_ROUND_WIN_NUMBER:
            tfCount.setMinNumber(num: 0)
            tfCount.setMaxNumber(num: 3)
            lbCountTitle.text = "직전 회차 당첨번호 중 n개 이상 포함"
            lbDesc.isHidden = false
            lbDesc.text = "0개 : 직전회차 당첨번호 모두 제외한다"
            tfCount.setNumber(num: DefaultsUtil.shared.getInt(FILTER_KEY.CNT_INCLUDE_LAST_ROUND_WIN_NUMBER))
            
        case .EXCLUDE_CONSECUTIVE_NUMBER:
            tfCount.setMinNumber(num: 1)
            tfCount.setMaxNumber(num: 4)
            lbCountTitle.text = "n개 이상 연속된 수 제외"
            lbDesc.isHidden = false
            lbDesc.text = "1개 : 연속된 수가 하나도 없다"
            tfCount.setNumber(num: DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_CONSECUTIVE_NUMBER))
        }
        
        chkBonus.isChecked = true
        chkBonus.isHidden = !isBonusShow
        
        mLayoutType = .INPUT_COUNT
    }
}
