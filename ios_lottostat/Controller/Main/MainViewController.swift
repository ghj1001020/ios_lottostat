//
//  MainViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 로또번호 추천화면으로 이동
    @IBAction func moveToRecommend(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "RecommendViewController", bundle: nil)
        var controller : MainViewController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "recommend") as? MainViewController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "recommend") as? MainViewController
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }
}
