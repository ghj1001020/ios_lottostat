//
//  MainViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import UIKit
import KWDrawerController

class MainViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 로또번호 추천화면으로 이동
    @IBAction func moveToRecommend(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "RecommendViewController", bundle: nil)
        var controller : DrawerController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "drawer") as? DrawerController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "drawer") as? DrawerController
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            delegate?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // 나의 로또번호화면으로 이동
    @IBAction func moveToMyLotto(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "MyLottoViewController", bundle: nil)
        var controller : MyLottoViewController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "myLotto") as? MyLottoViewController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "myLotto") as? MyLottoViewController
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            delegate?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // 당첨번호
    @IBAction func moveToWinLotto(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "WinLottoViewController", bundle: nil)
        var controller : WinLottoViewController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "winLotto") as? WinLottoViewController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "winLotto") as? WinLottoViewController
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            delegate?.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // 시뮬레이션
    @IBAction func moveToSimulation(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "SimulationViewController", bundle: nil)
        var controller : SimulationViewController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "simulation") as? SimulationViewController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "simulation") as?
            SimulationViewController
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            delegate?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
