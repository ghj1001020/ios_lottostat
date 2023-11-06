//
//  MainViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import UIKit
import KWDrawerController

class MainViewController: BaseController {
    
    var lastRound = SQLiteService.selectLastRoundWinNumber()
    
    @IBOutlet var layoutNum: UIView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var num1: HJLottoLabel!
    @IBOutlet var num2: HJLottoLabel!
    @IBOutlet var num3: HJLottoLabel!
    @IBOutlet var num4: HJLottoLabel!
    @IBOutlet var num5: HJLottoLabel!
    @IBOutlet var num6: HJLottoLabel!
    @IBOutlet var numBonus: HJLottoLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    func initLayout() {
        layoutNum.backgroundColor = ColorUtil.main()
        lbTitle.textColor = ColorUtil.text()
        lbTitle.font = UIFont.boldSystemFont(ofSize: 28)
        lbTitle.text = "\(lastRound[0])회"
        num1.text = "\(lastRound[1])"
        num2.text = "\(lastRound[2])"
        num3.text = "\(lastRound[3])"
        num4.text = "\(lastRound[4])"
        num5.text = "\(lastRound[5])"
        num6.text = "\(lastRound[6])"
        numBonus.text = "\(lastRound[7])"
    }
}
