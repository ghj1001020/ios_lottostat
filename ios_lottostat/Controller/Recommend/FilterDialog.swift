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
        DefaultsUtil.shared.put(LAST_ROUND_WIN_NUMBER.SELECT, true)
        chkLastRoundWinNumber.isChecked = true
        chkLastRoundWinNumber.isUserInteractionEnabled = false
    }
    
    // n개 연속된 수
    func updateConsecutiveNumber() {
        DefaultsUtil.shared.put(CONSECUTIVE_NUMBER.SELECT, true)
        chkConsecutiveNumber.isChecked = true
        chkConsecutiveNumber.isUserInteractionEnabled = false
    }
    
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

