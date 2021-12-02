//
//  FilterDialogController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/04.
//

import UIKit

class FilterDialogController: UIViewController {
    
    enum LAYOUT_TYPE {
        case LIST
        case INPUT_COUNT
    }
    
    enum FILTER_TYPE {
        case EXCLUDE_PREV_WIN_NUMBER
        case INCLUDE_LAST_ROUND_WIN_NUMBER
        case EXCLUDE_CONSECUTIVE_NUMBER
    }
    
    var mLayoutType : LAYOUT_TYPE = .LIST
    var mFilterType : FILTER_TYPE = .EXCLUDE_PREV_WIN_NUMBER
 
    @IBOutlet var chkExcludePrevWinNumber: HJCheckBox!
    @IBOutlet var layoutFilterList: UIView!
    @IBOutlet var layoutInputCount: UIView!
    
    // 이전 당첨번호 n개 이상 일치시 제외
    var isExcludePrevWinNumberWithBonus : Bool = true
    
    
    override func viewDidLoad() {
        LogUtil.p("FilterDialogController")
        
        // 필터목록 인덱스
        chkExcludePrevWinNumber.tag = 0
    }
    
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
                DefaultsUtil.shared.put("", false)
            }
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
