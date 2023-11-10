//
//  WinLottoViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/02/13.
//

import Foundation
import UIKit

class WinLottoViewController : BaseController {
    
    @IBOutlet var tblWinLotto: UITableView!
    var mWinLottoList : [LottoWinNumber] = {
        SQLiteService.selectLottoWinNumber()
    }()
        
    
    override func viewDidLoad() {
        setAppBar(.BACK_MORE)
        setAppBarTitle("당첨추천")
        
        tblWinLotto.delegate = self
        tblWinLotto.dataSource = self
        tblWinLotto.showsVerticalScrollIndicator = false
        let newX = self.view.bounds.size.width-10
        tblWinLotto.frame = CGRect(x: newX, y: 0, width: 10, height: self.view.bounds.size.height)
    }
}

extension WinLottoViewController : UITableViewDelegate, UITableViewDataSource, WinLottoProtocol {
    
    func onLottoNumberClick(index: Int) {
        let controller = AppUtil.GetUIViewController("AnalysisDialog", "analysisDialog") as! AnalysisDialog
        controller.currentNumber = mWinLottoList[index]
        if( index+1 < mWinLottoList.count ) {
            controller.prevNumber = mWinLottoList[index+1]
        }
        let bottomSheet = AppUtil.GetBottomSheetViewController(controller)
        self.present(bottomSheet, animated: true)
    }
        
    func onInfoFoldingClick(isShow: Bool) {
        tblWinLotto.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mWinLottoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "winLottoCell", for: indexPath) as? WinLottoNumberTableCell else {
            return UITableViewCell()
        }
        let data = mWinLottoList[indexPath.row]
        cell.lbNo.text = "\(data.no)회"
        cell.lbDate.text = "(\(data.date.convertSeparator()))"
        cell.lbWin1.text = "\(data.win1)"
        cell.lbWin2.text = "\(data.win2)"
        cell.lbWin3.text = "\(data.win3)"
        cell.lbWin4.text = "\(data.win4)"
        cell.lbWin5.text = "\(data.win5)"
        cell.lbWin6.text = "\(data.win6)"
        cell.lbBonus.text = "\(data.bonus)"
        cell.lb1PlaceCnt.text = "\(data.place1Cnt)"
        cell.lb1PlaceAmt.text = "\(data.place1Amt)"
        cell.lb2PlaceCnt.text = "\(data.place2Cnt)"
        cell.lb2PlaceAmt.text = "\(data.place2Amt)"
        cell.lb3PlaceCnt.text = "\(data.place3Cnt)"
        cell.lb3PlaceAmt.text = "\(data.place3Amt)"
        cell.lb4PlaceCnt.text = "\(data.place4Cnt)"
        cell.lb4PlaceAmt.text = "\(data.place4Amt)"
        cell.lb5PlaceCnt.text = "\(data.place5Cnt)"
        cell.lb5PlaceAmt.text = "\(data.place5Amt)"
        cell.delegate = self
        cell.row = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
