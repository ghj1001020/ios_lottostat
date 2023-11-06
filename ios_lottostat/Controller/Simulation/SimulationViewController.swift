//
//  SimulationViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import UIKit

class SimulationViewController: BaseController {
    
    let winData : LottoWinNumber? = (UIApplication.shared.delegate as! AppDelegate).LottoWinNumberList.first
    var simulationList = [SimulationNumberData]() {
        didSet {
            showNoContent()
        }
    }
    
    var cntWin1 = 0
    var cntWin2 = 0
    var cntWin3 = 0
    var cntWin4 = 0
    var cntWin5 = 0
    
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
    @IBOutlet var lb1PlaceCnt: HJLabel!
    @IBOutlet var lb2PlaceCnt: HJLabel!
    @IBOutlet var lb3PlaceCnt: HJLabel!
    @IBOutlet var lb4PlaceCnt: HJLabel!
    @IBOutlet var lb5PlaceCnt: HJLabel!
    
    @IBOutlet var tblSimulation: UITableView!
    @IBOutlet var noContent: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBar(.BACK_MORE)
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
        
        clearSimulationItems()
        
        let list = LottoScript.generateLottoNumberList(round: winData!.no, count: 100)
        addSimulationItems(list)
        
        lb1PlaceCnt.text = "\(cntWin1)개"
        lb2PlaceCnt.text = "\(cntWin2)개"
        lb3PlaceCnt.text = "\(cntWin3)개"
        lb4PlaceCnt.text = "\(cntWin4)개"
        lb5PlaceCnt.text = "\(cntWin5)개"
        
        var total = lb1PlaceAmt.text.toDouble() * Double(cntWin1)
        total += lb2PlaceAmt.text.toDouble() * Double(cntWin2)
        total += lb3PlaceAmt.text.toDouble() * Double(cntWin3)
        total += lb4PlaceAmt.text.toDouble() * Double(cntWin4)
        total += lb5PlaceAmt.text.toDouble() * Double(cntWin5)
        lbTotal.text = total.addComma()
        
        tblSimulation.reloadData()
        
        layoutResult.isHidden = false
        chkFold.isChecked = true
        
        let runTime = Date().toMilliSeconds() - startTime
        LogUtil.p("runTime \(runTime) ms")
    }
    
    // 시뮬레이션 데이터 삭제
    func clearSimulationItems() {
        simulationList.removeAll()
        cntWin1 = 0
        cntWin2 = 0
        cntWin3 = 0
        cntWin4 = 0
        cntWin5 = 0
    }
    
    // 시뮬레이션 데이터 추가
    func addSimulationItems(_ list: [[Int]]) {
        for item in list {
            if item.count < 6 {
                continue
            }
            
            let numList = [item[0], item[1], item[2], item[3], item[4], item[5]]
            let winResult = winData?.getWinningResult(numbers: numList) ?? .NONE
            switch winResult {
            case .WIN1PLACE:
                cntWin1 += 1
                break
            case .WIN2PLACE:
                cntWin2 += 1
                break
            case .WIN3PLACE:
                cntWin3 += 1
                break
            case .WIN4PLACE:
                cntWin4 += 1
                break
            case .WIN5PLACE:
                cntWin5 += 1
                break
            default:
                break
            }
            simulationList.append(SimulationNumberData(numList[0], numList[1], numList[2], numList[3], numList[4], numList[5], winResult))
        }
    }
    
    func showNoContent() {
        if(simulationList.count > 0) {
            tblSimulation.isHidden = false
            noContent.isHidden = true
        }
        else {
            tblSimulation.isHidden = true
            noContent.isHidden = false
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
        return simulationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "simulationCell", for: indexPath) as? SimulationTableCell else {
            return UITableViewCell()
        }
        let data = simulationList[indexPath.row]
        cell.num1.text = "\(data.num1)"
        cell.num2.text = "\(data.num2)"
        cell.num3.text = "\(data.num3)"
        cell.num4.text = "\(data.num4)"
        cell.num5.text = "\(data.num5)"
        cell.num6.text = "\(data.num6)"
        switch data.result {
        case .WIN1PLACE:
            cell.lbResult.text = "1등"
            break
        case .WIN2PLACE:
            cell.lbResult.text = "2등"
            break
        case .WIN3PLACE:
            cell.lbResult.text = "3등"
            break
        case .WIN4PLACE:
            cell.lbResult.text = "4등"
            break
        case .WIN5PLACE:
            cell.lbResult.text = "5등"
            break
        default:
            cell.lbResult.text = ""
            break
        }
        cell.divider.isHidden = indexPath.row == simulationList.count-1 ? true : false
        return cell
    }
}
