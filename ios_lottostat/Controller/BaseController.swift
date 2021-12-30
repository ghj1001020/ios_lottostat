//
//  BaseController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/10/05.
//

import Foundation
import UIKit

class BaseController : UIViewController {
    
    public var appBar: LTAppBar? = nil
    
    @IBOutlet weak var titleBarView: UIView!
    private var titleBar: LTAppBar? = nil
    
    
    override func viewDidLoad() {
        setAppBar()
    }
    
    func setAppBar() {
        guard let xib = Bundle.main.loadNibNamed("LTAppBar", owner: self, options: nil)?.first as? LTAppBar else  {
            return
        }
        
        titleBar = xib
        titleBar?.delegate = self
        self.titleBarView.addSubview(titleBar!)
    }    
}

extension BaseController : LTAppBarPortocol {
    func onBackButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func onMoreButtonClick() {
        drawerController?.openSide(.left)
    }
    
    // 타이틀명 변경
    func setAppBarTitle(_ title: String) {
        self.titleBar?.setTitle(title)
    }
}
