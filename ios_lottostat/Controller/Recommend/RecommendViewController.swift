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
        let controller = AppUtil.GetUIViewController("FilterDialog", "filterDialog")
        let bottomSheet = AppUtil.GetBottomSheetViewController(controller as! BaseBottomSheetContent)
        self.present(bottomSheet, animated: true)
    }
    
    // 번호생성 클릭
    @IBAction func onGenerateLottoNumber(_ sender: LTGradientButton) {
        generateLottoNumber(count: 10)
    }
    
    // 저장 클릭
    @IBAction func onSaveLottoNumver(_ sender: UIButton) {
        if( self.mLottoList.count == 0 ) {
            AlertUtil.Alert(self, "번호를 생성하세요.").show()
            return
        }

        let alert = AlertUtil.Alert(self, "저장하시겠습니까?")
        alert.setNegative()
        alert.setPositive {
            SQLiteService.insertMyLottoData(self.mLottoNo, self.mLottoList)
        }
        alert.show()
    }
    
    
    // 번호생성
    func generateLottoNumber(count: Int) {
        let startTime = Date().toMilliSeconds()
        
        self.mLottoList.removeAll()
        let list = LottoScript.GenerateLottoNumberList(round: mLottoNo, count: count)
        self.mLottoList.append(contentsOf: list)
        tblLottoNumber.reloadData()
        renderLottoNumberList()
        
        let runTime = Date().toMilliSeconds() - startTime
        LogUtil.p("runTime \(runTime) ms")
    }
    
    func renderLottoNumberList() {
        if( mLottoList.isEmpty ) {
            tblLottoNumber.isHidden = true
            viewNoContent.isHidden = false
        }
        else {
            tblLottoNumber.isHidden = false
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
