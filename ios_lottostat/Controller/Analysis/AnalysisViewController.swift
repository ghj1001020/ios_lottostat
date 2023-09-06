//
//  AnalysisController.swift
//  ios_lottostat
//
//  Created by tsis001 on 2023/08/04.
//

import UIKit

class AnalysisViewController : BaseController {
    
    let winDataList : [LottoWinNumber] = (UIApplication.shared.delegate as! AppDelegate).LottoWinNumberList
    
    override func viewDidLoad() {
        
    }
    
    // 이전회차 번호가 1개이상 나올 경우
    func CaseGetPreNumber() {
        for item in winDataList {
            if( item.no - 1 > 0 ) {
                var preNum = winDataList[item.no - 1];
                
            }
        }
    }
    
    // 연속수가 2~3개인 경우
    func CaseConsecutive() {
        
    }
    
    // 과거당첨번호 중 3개이하인 경우
    
    // 모든합이 100 ~ 170 인경우
    
    // 짝:홀 비율이 2:4,3:3,4:2 인경우
    
    
}
