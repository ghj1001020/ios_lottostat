//
//  SideMenu.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2023/11/10.
//

import UIKit

class SideMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 로또번호 추천
    @IBAction func moveToRecommend(_ sender: UIButton) {
        drawerController?.closeSide()
        let controller = AppUtil.GetUIViewController("MainViewController", "recommend")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // 시뮬레이션
    @IBAction func moveToSimulation(_ sender: UIButton) {
        drawerController?.closeSide()
        let controller = AppUtil.GetUIViewController("MainViewController", "simulation")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // 당첨번호
    @IBAction func moveToWinLotto(_ sender: UIButton) {
        drawerController?.closeSide()
        let controller = AppUtil.GetUIViewController("MainViewController", "winLotto")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // 나의로또번호
    @IBAction func moveToMyLotto(_ sender: UIButton) {
        drawerController?.closeSide()
        let controller = AppUtil.GetUIViewController("MainViewController", "myLotto")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
