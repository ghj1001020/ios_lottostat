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
    
}
