//
//  MainViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import UIKit
import KWDrawerController

class MainViewController: UIViewController {

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
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func moveToMyLotto(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "MyLottoViewController", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "myLotto") as? MyLottoViewController else {
            return
        }
        
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
}
