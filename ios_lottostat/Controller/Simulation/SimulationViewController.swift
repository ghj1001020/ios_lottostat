//
//  SimulationViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import UIKit

class SimulationViewController: BaseController {
    
    let winData : LottoWinNumber? = (UIApplication.shared.delegate as! AppDelegate).LottoWinNumberList.first
    
    @IBOutlet var layoutRound: HJView!
    @IBOutlet var chkFold: HJCheckImageView!
    @IBOutlet var layoutResult: UIView!
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
        if let winData = winData {
            lbWinNo.text = "\(winData.no)회 당첨번호"
            num1.text = "\(winData.win1)"
            num2.text = "\(winData.win2)"
            num3.text = "\(winData.win3)"
            num4.text = "\(winData.win4)"
            num5.text = "\(winData.win5)"
            num6.text = "\(winData.win6)"
            numBonus.text = "\(winData.bonus)"
            lb1PlaceAmt.text = winData.place1Amt
            lb2PlaceAmt.text = winData.place2Amt
            lb3PlaceAmt.text = winData.place3Amt
            lb4PlaceAmt.text = winData.place4Amt
            lb5PlaceAmt.text = winData.place5Amt
        }
        
        layoutRound.delegate = self
    }

    // 필터 다이얼로그
    @IBAction func onFilterClick(_ sender: UIButton) {
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
    
}

extension SimulationViewController : HJViewEvent {
    // 라운드 클릭
    func onClickEvent(view: HJView) {
        layoutResult.isHidden = !layoutResult.isHidden
        chkFold.isChecked = !layoutResult.isHidden
    }
}
