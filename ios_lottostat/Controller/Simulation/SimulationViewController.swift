//
//  SimulationViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import UIKit

class SimulationViewController: BaseController {
    
    let winData : LottoWinNumber? = (UIApplication.shared.delegate as! AppDelegate).LottoWinNumberList.first
    var simulationList = [SimulationNumberData]()
    
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
    
    // 시뮬레이션
    @IBAction func onSimulationClick(_ sender: UIButton) {
        if(winData == nil) {
            return
        }
        let startTime = Date().toMilliSeconds()
        
        simulationList.removeAll()
        var list = LottoScript.generateLottoNumberList(round: winData!.no, count: 100)
        list.append([1,3,9,14,18,28])
        list.append([1,34,9,14,18,28])
        list.append([1,3,9,14,44,28])
        list.append([1,3,9,14,44,45])
        list.append([2,3,11,14,38,28])
        addSimulationItems(list)
        
        let runTime = Date().toMilliSeconds() - startTime
        LogUtil.p("runTime \(runTime) ms")
    }
    
    // 시뮬레이션 데이터 추가
    func addSimulationItems(_ list: [[Int]]) {
        for item in list {
            if item.count < 6 {
                continue
            }
            
            let numList = [item[0], item[1], item[2], item[3], item[4], item[5]]
            let winResult = winData?.getWinningResult(numbers: numList)
            simulationList.append(SimulationNumberData(item[0], <#T##num2: Int##Int#>, <#T##num3: Int##Int#>, <#T##num4: Int##Int#>, <#T##num5: Int##Int#>, <#T##num6: Int##Int#>, <#T##result: WIN_RATE##WIN_RATE#>)
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

extension SimulationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "simulationCell", for: indexPath) as? SimulationTableCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
