//
//  WinLottoNumberTableCell.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/02/13.
//

import Foundation
import UIKit


protocol WinLottoProtocol {
    func onInfoFoldingClick(isShow: Bool)
    func onLottoNumberClick(index: Int)
}

class WinLottoNumberTableCell : UITableViewCell {

    @IBOutlet var layoutRound: UIView!
    @IBOutlet var lbNo: UILabel!
    @IBOutlet var lbDate: UILabel!
    @IBOutlet var imgArrow: UIImageView!

    @IBOutlet var lbWin1: HJLottoLabel!
    @IBOutlet var lbWin2: HJLottoLabel!
    @IBOutlet var lbWin3: HJLottoLabel!
    @IBOutlet var lbWin4: HJLottoLabel!
    @IBOutlet var lbWin5: HJLottoLabel!
    @IBOutlet var lbWin6: HJLottoLabel!
    @IBOutlet var lbBonus: HJLottoLabel!
    
    @IBOutlet var layoutInfo: UIStackView!
    @IBOutlet var lb1PlaceCnt: UILabel!
    @IBOutlet var lb1PlaceAmt: HJLabel!
    @IBOutlet var lb2PlaceCnt: UILabel!
    @IBOutlet var lb2PlaceAmt: HJLabel!
    @IBOutlet var lb3PlaceCnt: UILabel!
    @IBOutlet var lb3PlaceAmt: HJLabel!
    @IBOutlet var lb4PlaceCnt: UILabel!
    @IBOutlet var lb4PlaceAmt: HJLabel!
    @IBOutlet var lb5PlaceCnt: UILabel!
    @IBOutlet var lb5PlaceAmt: HJLabel!
    
    var row = 0
    var delegate : WinLottoProtocol? = nil
    
    
    @IBAction func onLayoutInfoFold(_ sender: UIButton) {
        layoutInfo.isHidden = !layoutInfo.isHidden
        imgArrow.image = !layoutInfo.isHidden ? UIImage(named: "ic_arrow_u") : UIImage(named: "ic_arrow_d")
        delegate?.onInfoFoldingClick(isShow: !layoutInfo.isHidden)
    }
    
    @IBAction func onLottoNumberClick(_ sender: UIButton) {
        delegate?.onLottoNumberClick(index: row)
    }
}
