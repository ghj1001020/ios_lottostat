//
//  BaseController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/10/05.
//

import Foundation
import UIKit

class BaseController : UIViewController {
    
    @IBOutlet var appBar: LTAppBar!
    
    
    override func viewDidLoad() {
        self.appBar.delegate = self
    }
    
    func setAppBar() {
        guard let xib = Bundle.main.loadNibNamed("LTAppBar", owner: self, options: nil)?.first as? LTAppBar else  {
            return
        }
        xib.delegate = self
        let safeArea : UIView = UIView()
        safeArea.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(safeArea)
        
        if #available(iOS 11, *) {
            let safeAreaGuide = view.safeAreaLayoutGuide
            safeArea.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        }
        safeArea.addSubview(xib)
    }
    
}

extension BaseController : LTAppBarPortocol {
    
    // 왼쪽 버튼 클릭
    @objc func onLeftButtonClick() {
//        dismiss(animated: true, completion: nil)
        drawerController?.openSide(.left)
    }
    
    // 타이틀명 변경
    func setAppBarTitle(_ title: String) {
        self.appBar.setTitle(title)
    }
}
