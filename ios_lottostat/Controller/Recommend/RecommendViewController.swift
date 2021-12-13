//
//  RecommendViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/27.
//

import UIKit
import KWDrawerController

class RecommendViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBarTitle("번호추천")
    }
    
    // 필터버튼 클릭
    @IBAction func onFilter(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "FilterDialogController", bundle: nil)
        var controller : FilterDialogController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "filterDialog") as? FilterDialogController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "filterDialog") as? FilterDialogController
        }

        if let controller = controller {
            let filterDialog = BottomSheetController(contentController: controller)
            filterDialog.isCancelable = false
            filterDialog.modalPresentationStyle = .overFullScreen
            self.present(filterDialog, animated: false, completion: nil)
        }
    }
    
    // 번호생성 클릭
    @IBAction func onGenerateLottoNumber(_ sender: LTGradientButton) {
        generateLottoNumber(count: 20)
    }
    
    // 번호생성
    func generateLottoNumber(count: Int) {
        let startTime = Date().toMilliSeconds()
        
        let isExcludePrevWinNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER, FILTER_KEY.DFT_IS_EXCLUDE_PREV_WIN_NUMBER)
        let cntExcludePrevWinNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_PREV_WIN_NUMBER, FILTER_KEY.DFT_CNT_EXCLUDE_PREV_WIN_NUMBER)
        let isExcludePrevWinNumberWithBonus = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS, FILTER_KEY.DFT_IS_EXCLUDE_PREV_WIN_NUMBER_WITH_BONUS)
        
        let isIncludeLastRoundWinNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER, FILTER_KEY.DFT_IS_INCLUDE_LAST_ROUND_WIN_NUMBER)
        let cntIncludeLastRoundWinNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_INCLUDE_LAST_ROUND_WIN_NUMBER, FILTER_KEY.DFT_CNT_INCLUDE_LAST_ROUND_WIN_NUMBER)
        let isIncludeLastRoundWinNumberWithBonus = DefaultsUtil.shared.getBool(FILTER_KEY.IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS, FILTER_KEY.DFT_IS_INCLUDE_LAST_ROUND_WIN_NUMBER_WITH_BONUS)
        
        let isExcludeConsecutiveNumber = DefaultsUtil.shared.getBool(FILTER_KEY.IS_EXCLUDE_CONSECUTIVE_NUMBER, FILTER_KEY.DFT_IS_EXCLUDE_CONSECUTIVE_NUMBER)
        let cntExcludeConsecutiveNumber = DefaultsUtil.shared.getInt(FILTER_KEY.CNT_EXCLUDE_CONSECUTIVE_NUMBER, FILTER_KEY.DFT_CNT_EXCLUDE_CONSECUTIVE_NUMBER)
        
        var index : Int = 0
        var LOTTO : [Int] = []
        
        while( index < count ) {
            // 번호생성
            LOTTO.removeAll()
            // 로또번호 1~45
            var GROUP : [Int] = DefineCode.LOTTERY.map({
                $0
            })
            
            // 직전회차 당첨번호 중 n개이상 포함
            if( isIncludeLastRoundWinNumber ) {
                var lastRound = SQLiteService.selectLastRoundWinNumber(isBonus: isExcludePrevWinNumberWithBonus)
                // 0 <= idx < cntIncludeLastRoundWinNumber
                for _ in 0..<cntIncludeLastRoundWinNumber {
                    // 인덱스 구해서 추천번호 뽑기
                    let tempIndex : Int = Int( arc4random_uniform(UInt32(lastRound.count)) )
                    let goodNumber : Int = lastRound[tempIndex]
                    LOTTO.append(goodNumber)
                    // 당첨번호에서 추가한 번호삭제
                    lastRound.remove(at: tempIndex)
                    if let _index = GROUP.firstIndex(of: goodNumber) {
                        GROUP.remove(at: _index)
                    }
                }
            }
            
            while LOTTO.count < 6 {
                // 이전 당첨번호와 n개이상 일치시 제외
                if isExcludePrevWinNumber {
                    if( LOTTO.count == cntExcludePrevWinNumber-1 ) {
                        // 0번째 번호가 포함된 로또당첨번호 리스트
                        let list : [Int] = SQLiteService.selectPrevWinNumberByNum()
                    }
                }
            }
            
            // 인덱스 1추가
            index += 1
        }
        
        
        let runTime = Date().toMilliSeconds() - startTime
        LogUtil.p("runTime \(runTime) ms")
    }
    
}
