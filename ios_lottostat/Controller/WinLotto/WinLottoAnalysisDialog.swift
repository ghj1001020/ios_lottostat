//
//  WinLottoAnalysisDialog.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/02/25.
//

import Foundation
import UIKit

class WinLottoAnalysisDialog : BaseBottomSheetContent {
    
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbLastRoundMatchCount1: UILabel!
    @IBOutlet var lbLastRoundMatchCount2: UILabel!
    @IBOutlet var lbConsecutiveCount1: UILabel!
    @IBOutlet var lbConsecutiveCount2: UILabel!
    
    
    var currentNumber : LottoWinNumber!
    var prevNumber : LottoWinNumber? = nil
    
    
    override func viewDidLoad() {
        lbTitle.text = "\(currentNumber.no)회 번호분석"
        checkPrevRoundMatchCount()
        checkConsecutiveCount()
    }
    
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 직전회차 당첨번호와 일치하는 번호
    func checkPrevRoundMatchCount() {
        if( prevNumber == nil ) {
            lbLastRoundMatchCount1.text = "0"
            lbLastRoundMatchCount2.text = "0"
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let curList1 = self.currentNumber.getNumberList(isBonus: false)
            let prevList1 = self.prevNumber!.getNumberList(isBonus: false)
            let count1 = curList1.GetMatchCount(other: prevList1)
            
            let curList2 = self.currentNumber.getNumberList(isBonus: false)
            let prevList2 = self.prevNumber!.getNumberList()
            let count2 = curList2.GetMatchCount(other: prevList2)
            
            DispatchQueue.main.async {
                self.lbLastRoundMatchCount1.text = "\(count1)"
                self.lbLastRoundMatchCount2.text = "\(count2)"
            }
        }
    }
    
    // 최대로 연속하는 갯수
    func checkConsecutiveCount() {
        DispatchQueue.global(qos: .userInitiated).async {
            var curList1 = self.currentNumber.getNumberList(isBonus: false)
            let count1 = curList1.GetConsecutiveCount()
            
            var curList2 = self.currentNumber.getNumberList()
            let count2 = curList2.GetConsecutiveCount()
            
            DispatchQueue.main.async {
                self.lbConsecutiveCount1.text = "\(count1)"
                self.lbConsecutiveCount2.text = "\(count2)"
            }
        }
    }
}
