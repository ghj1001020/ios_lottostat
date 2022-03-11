//
//  FilterDialog.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/06.
//

import Foundation
import UIKit

class FilterDialog : BaseBottomSheetContent {
    
    // 필터 > 목록
    @IBOutlet var chkLastRoundWinNumber: HJCheckBox!
    @IBOutlet var chkConsecutiveNumber: HJCheckBox!
    
    // 필터 > 입력
    @IBOutlet var lbInputCountTitle: UILabel!
    @IBOutlet var etInputCount: HJFilterTextField!
    @IBOutlet var chkInputCountBonus: HJCheckBox!
    @IBOutlet var lbInputCountDesc: HJLabel!
    @IBOutlet var crInputCountDescTop: NSLayoutConstraint!
    
    
    @IBOutlet var layoutFilterList: UIView!
    @IBOutlet var layoutInputCount: UIView!
    
    var mLayoutType : LAYOUT_TYPE = .LIST
    var mFilterType : FILTER_TYPE = .LAST_ROUND_WIN_NUMBER
    
    
    override func viewDidLoad() {
        initLayout()
    }
    
    func initLayout() {
        // 이전 회차 번호 중 n개 일치
        updateLastRoundWinNumber()
        // n개 연속된 수
        updateConsecutiveNumber()
    }
    
    // 이전 회차 번호 중 n개 일치
    func updateLastRoundWinNumber() {
        let select = DefaultsUtil.shared.getBool(LAST_ROUND_WIN_NUMBER.SELECT, LAST_ROUND_WIN_NUMBER.DFT_SELECT)
        let cnt = DefaultsUtil.shared.getInt(LAST_ROUND_WIN_NUMBER.CNT, LAST_ROUND_WIN_NUMBER.DFT_CNT)
        let bonus = DefaultsUtil.shared.getBool(LAST_ROUND_WIN_NUMBER.BONUS, LAST_ROUND_WIN_NUMBER.DFT_BONUS)
        
        chkLastRoundWinNumber.isChecked = select
        if(select) {
            let strBonus = bonus ? "보너스 포함" : "보너스 미포함"
            chkLastRoundWinNumber.setTitle(String(format: "이전 회차 번호 중 %d개 일치 (%@)", cnt, strBonus), for: .normal)
        }
        else {
            chkLastRoundWinNumber.setTitle("이전 회차 번호 중 n개 일치", for: .normal)
        }
    }
    
    // n개 연속된 수
    func updateConsecutiveNumber() {
        let select = DefaultsUtil.shared.getBool(CONSECUTIVE_NUMBER.SELECT, CONSECUTIVE_NUMBER.DFT_SELECT)
        let cnt = DefaultsUtil.shared.getInt(CONSECUTIVE_NUMBER.CNT, CONSECUTIVE_NUMBER.DFT_CNT)
        
        chkConsecutiveNumber.isChecked = select
        let strCnt = select ? "\(cnt)" : "n"
        chkConsecutiveNumber.setTitle(String(format: "%@개 연속된 수 포함", strCnt), for: .normal)
    }
    
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        cancelFilterSetting()
        dismissDialog()
    }
    
    // 필터 설정 취소
    func cancelFilterSetting() {
        if(mLayoutType == .LIST) {
            return
        }
        
        if(mFilterType == .LAST_ROUND_WIN_NUMBER) {
            chkLastRoundWinNumber.isChecked = false
        }
        else if(mFilterType == .CONSECUTIVE_NUMBER) {
            chkConsecutiveNumber.isChecked = false
        }
    }
    
    // 다이얼로그 닫기
    func dismissDialog() {
        if(mLayoutType != .LIST ) {
            mLayoutType = .LIST
            changeFilterLayout()
            return
        }
        dismiss(animated: true, completion: nil)
    }

    // 필터 선택 변경
    @IBAction func onFilterChanged(_ sender: HJCheckBox) {
        switch sender.tag {
        // 이전 회차 번호 중 n개 일치
        case 1000:
            if(sender.isChecked) {
                mFilterType = .LAST_ROUND_WIN_NUMBER
                mLayoutType = .INPUT_COUNT
                changeFilterLayout()
                let bonus = DefaultsUtil.shared.getBool(LAST_ROUND_WIN_NUMBER.BONUS, LAST_ROUND_WIN_NUMBER.DFT_BONUS)
                setInputCount(true, bonus)
            }
            else {
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.SELECT, false)
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.CNT, LAST_ROUND_WIN_NUMBER.DFT_CNT)
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.BONUS, LAST_ROUND_WIN_NUMBER.DFT_BONUS)
            }
            break
            
        // n개 연속된 수
        case 1001:
            if(sender.isChecked) {
                mFilterType = .CONSECUTIVE_NUMBER
                mLayoutType = .INPUT_COUNT
                changeFilterLayout()
                setInputCount(false, false)
            }
            else {
                DefaultsUtil.shared.put(CONSECUTIVE_NUMBER.SELECT, false)
                DefaultsUtil.shared.put(CONSECUTIVE_NUMBER.CNT, CONSECUTIVE_NUMBER.DFT_CNT)
            }
            break

        default:
            break
        }
    }
    
    // 입력화면 클릭
    @IBAction func onInputCountClick(_ sender: UIButton) {
        switch sender.tag {
        // 입력 > -버튼
        case 2000:
            etInputCount.minus()
            break
            
        // 입력 > +버튼
        case 2001:
            etInputCount.add()
            break
            
        // 입력 > 취소
        case 2002:
            cancelFilterSetting()
            dismissDialog()
            break
            
        // 입력 > 확인
        case 2003:
            let cnt = etInputCount.mCurrentNumber
            let bonus = chkInputCountBonus.isChecked
            if( mFilterType == .LAST_ROUND_WIN_NUMBER) {
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.SELECT, true)
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.CNT, cnt)
                DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.BONUS, bonus)
                updateLastRoundWinNumber()
            }
            else if(mFilterType == .CONSECUTIVE_NUMBER) {
                DefaultsUtil.shared.put(CONSECUTIVE_NUMBER.SELECT, true)
                DefaultsUtil.shared.put(CONSECUTIVE_NUMBER.CNT, cnt)
                updateConsecutiveNumber()
            }
            dismissDialog()
            break
            
        default:
            break
        }
    }
    
    // 목록-입력 레이아웃 변경
    func changeFilterLayout() {
        if(mLayoutType == .LIST) {
            layoutFilterList.isHidden = false
            layoutInputCount.isHidden = true
        }
        else if(mLayoutType == .INPUT_COUNT) {
            layoutFilterList.isHidden = true
            layoutInputCount.isHidden = false
        }
    }
    
    // 입력화면
    func setInputCount(_ isBonusShow: Bool, _ isBonus: Bool) {
        switch mFilterType {
        case .LAST_ROUND_WIN_NUMBER:
            lbInputCountTitle.text = "이전 회차 번호 중 n개 일치"
            etInputCount.minNum = 0
            etInputCount.maxNum = 4
            let cnt = DefaultsUtil.shared.getInt(LAST_ROUND_WIN_NUMBER.CNT, LAST_ROUND_WIN_NUMBER.DFT_CNT)
            etInputCount.setNumber(num: cnt)
            lbInputCountDesc.text = "0개 : 직전회차 당첨번호 모두 제외한다"
            break
            
        case .CONSECUTIVE_NUMBER:
            lbInputCountTitle.text = "n개 연속된 수 포함"
            etInputCount.minNum = 0
            etInputCount.maxNum = 3
            let cnt = DefaultsUtil.shared.getInt(CONSECUTIVE_NUMBER.CNT, CONSECUTIVE_NUMBER.DFT_CNT)
            etInputCount.setNumber(num: cnt)
            lbInputCountDesc.text = "확률상 불가능하면 더 많거나 적은 갯수의 연속수가 나올 수 있다"
            break
        }
        
        if(isBonusShow) {
            chkInputCountBonus.isChecked = true
            chkInputCountBonus.isHidden = false
            crInputCountDescTop.constant = 56
        }
        else {
            chkInputCountBonus.isChecked = false
            chkInputCountBonus.isHidden = true
            crInputCountDescTop.constant = 18
        }
    }
}

enum LAYOUT_TYPE : Int {
    case LIST = 0
    case INPUT_COUNT
}

enum FILTER_TYPE {
    case LAST_ROUND_WIN_NUMBER
    case CONSECUTIVE_NUMBER
}
