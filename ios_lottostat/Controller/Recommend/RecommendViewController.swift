//
//  RecommendViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/27.
//

import UIKit
import KWDrawerController

class RecommendViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBarTitle("번호추천")
    }
    
    // 필터버튼 클릭
    @IBAction func onFilter(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "FilterDialogController", bundle: nil)
        var controller : FilterDialogController? = nil
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: "filterDialog") as? FilterDialogController
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "filterDialog") as? FilterDialogController
        }

        if let controller = controller {
            let filterDialog = BottomSheetController(contentController: controller)
            filterDialog.modalPresentationStyle = .overFullScreen
            self.present(filterDialog, animated: false, completion: nil)
        }
    }
}
