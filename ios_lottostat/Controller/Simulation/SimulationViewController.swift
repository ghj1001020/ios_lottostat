//
//  SimulationViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import UIKit

class SimulationViewController: BaseController {
    
    let winData : LottoWinNumber = (UIApplication.shared.delegate as! AppDelegate).LottoWinNumberList.first!
    
    @IBOutlet var lbTotal: HJLabel!
    @IBOutlet var lbWinNo: UILabel!
    @IBOutlet var num1: HJLottoLabel!
    @IBOutlet var num2: HJLottoLabel!
    @IBOutlet var num3: HJLottoLabel!
    @IBOutlet var num4: HJLottoLabel!
    @IBOutlet var num5: HJLottoLabel!
    @IBOutlet var num6: HJLottoLabel!
    @IBOutlet var numBonus: HJLottoLabel!
    @IBOutlet var lb1PlaceAmt: UILabel!
    @IBOutlet var lb2PlaceAmt: UILabel!
    @IBOutlet var lb3PlaceAmt: UILabel!
    @IBOutlet var lb4PlaceAmt: UILabel!
    @IBOutlet var lb5PlaceAmt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBar(.BACK)
        setAppBarTitle("시뮬레이션")

        lbTotal.text = ""
        lbWinNo.text = "\(winData.no)회 당첨번호"
        num1.text = ""
    }

}
