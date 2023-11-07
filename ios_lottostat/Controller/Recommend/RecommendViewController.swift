//
//  RecommendViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/27.
//

import UIKit
import KWDrawerController

class RecommendViewController: BaseController {
    
    // 번호추출 로또 데이터 리스트
    private var mLottoList : [[Int]] = []
    
    // 번호추출 회차
    private let mLottoNo = {
        return SQLiteService.selectMaxNo() + 1
    }()
    
    // 번호추출 목록
    @IBOutlet var tblLottoNumber: UITableView!
    @IBOutlet var viewNoContent: UIView!
    @IBOutlet var btnSave: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBar(.BACK_MORE)
        setAppBarTitle("\(mLottoNo)회 번호추천")
        
        self.tblLottoNumber.delegate = self
        self.tblLottoNumber.dataSource = self
    }
    
    // 필터버튼 클릭
    @IBAction func onFilter(_ sender: UIButton) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "FilterDialog", bundle: nil)
        var controller : FilterDialog? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "filterDialog") as? FilterDialog
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "filterDialog") as? FilterDialog
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
    
    // 저장 클릭
    @IBAction func onSaveLottoNumver(_ sender: UIButton) {
        if( self.mLottoList.count == 0 ) {
            AlertUtil.Alert(self, "", "번호를 생성하세요.").show()
            return
        }

        let alert = AlertUtil.Alert(self, "", "저장하시겠습니까?")
        alert.setNegative()
        alert.setPositive {
            SQLiteService.insertMyLottoData(self.mLottoNo, self.mLottoList)
        }
        alert.show()
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
        
        self.mLottoList.removeAll()
        while( index < count ) {
            // 번호생성
            LOTTO.removeAll()
            // 로또번호 1~45
            var GROUP : [Int] = DefineCode.LOTTERY.map({
                $0
            })
            
            // 직전회차 당첨번호 중 n개이상 포함
            if( isIncludeLastRoundWinNumber ) {
                var lastRound = SQLiteService.selectLastRoundWinNumber()
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
                        let list : [[Int]] = SQLiteService.selectPrevWinNumberByNum(num: LOTTO[0], isBonus: isExcludePrevWinNumberWithBonus)
                        
                        for item in list {
                            let WIN_NUMBER : [Int] = item
                            var isPrevWinNumber : Bool = true   // 이전번호와 n-1개 일치여부
                            // 이전 당첨번호와 n-1개 일치하는지 체크
                            for _lotto in LOTTO {
                                if( !WIN_NUMBER.contains(_lotto) ) {
                                    isPrevWinNumber = false
                                    break
                                }
                            }
                            
                            // 이전번호와 n-1개 일치하면 나머지번호 삭제
                            if( isPrevWinNumber ) {
                                for _winNumber in WIN_NUMBER {
                                    if let _index = GROUP.firstIndex(of: _winNumber) {
                                        GROUP.remove(at: _index)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 번호추천
                let numIndex = Int( arc4random_uniform(UInt32(GROUP.count)) )
                let number = GROUP[numIndex]
                
                // 추천번호 결과담고 모그룹에서 삭제
                LOTTO.append(number)
                LOTTO.sort()
                GROUP.remove(at: numIndex)
                
                // n개이상 연속된 수 체크
                if( isExcludeConsecutiveNumber ) {
                    var isConsecutive : Bool = false    // 결과체크
                    var cntConsecutive = 1  // 연속된수 개수
                    var temp : Int = -1 // 이전번호
                    for _lotto in LOTTO {
                        // 두수 사이 간격이 1이면 이전번호와 연속된 수
                        if( abs(temp-_lotto) <= 1 ) {
                            // 지금까지 연속수 >= n 연속수 한계 설정개수
                            cntConsecutive += 1
                            if( cntConsecutive >= cntExcludeConsecutiveNumber ) {
                                isConsecutive = true
                                break
                            }
                        }
                        // 이전번호와 연속되지 않은 수
                        else {
                            cntConsecutive = 1
                        }
                        temp = _lotto
                    }
                    
                    // n개이상 연속된 수이면 지우고 다시하기
                    if isConsecutive {
                        if let _index = LOTTO.firstIndex(of: number) {
                            LOTTO.remove(at: _index)
                        }
                        continue
                    }
                }
            }
            
            // 번호 추천 목록에 담기
            self.mLottoList.append( LOTTO )
            
            // 인덱스 1추가
            index += 1
        }
        tblLottoNumber.reloadData()
        renderLottoNumberList()
        
        let runTime = Date().toMilliSeconds() - startTime
        LogUtil.p("runTime \(runTime) ms")
    }
    
    func renderLottoNumberList() {
        if( mLottoList.isEmpty ) {
            tblLottoNumber.isHidden = true
            btnSave.isHidden = true
            viewNoContent.isHidden = false
        }
        else {
            tblLottoNumber.isHidden = false
            btnSave.isHidden = false
            viewNoContent.isHidden = true
        }
    }

}

// 번호추출 목록
extension RecommendViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mLottoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lottoNumberCell", for: indexPath) as? RecommendLottoNumberTableCell else {
            return UITableViewCell()
        }
        
        cell.lbNum1.text = String(self.mLottoList[indexPath.row][0])
        cell.lbNum2.text = String(self.mLottoList[indexPath.row][1])
        cell.lbNum3.text = String(self.mLottoList[indexPath.row][2])
        cell.lbNum4.text = String(self.mLottoList[indexPath.row][3])
        cell.lbNum5.text = String(self.mLottoList[indexPath.row][4])
        cell.lbNum6.text = String(self.mLottoList[indexPath.row][5])
        
        cell.divider.isHidden = indexPath.row == self.mLottoList.count-1 ? true : false

        return cell
    }
}
