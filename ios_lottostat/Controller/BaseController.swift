//
//  BaseController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/10/05.
//

import Foundation
import UIKit

enum APPBAR {
    case BACK
    case BACK_MORE
}

class BaseController : UIViewController {
    
    public var appBar: LTAppBar? = nil
    public let delegate = UIApplication.shared.delegate as? AppDelegate
    
    
    @IBOutlet weak var titleBarView: UIView!
    private var titleBar: LTAppBar? = nil
    
    
    override func viewDidLoad() {
        
    }
    
    func setAppBar(_ type: APPBAR) {
        guard let xib = Bundle.main.loadNibNamed("LTAppBar", owner: self, options: nil)?.first as? LTAppBar else  {
            return
        }
        
        titleBar = xib
        titleBar?.delegate = self
        titleBar?.initUI(type)
        
        self.titleBarView.addSubview(titleBar!)
    }
}

extension BaseController : LTAppBarPortocol {
    func onBackButtonClick() {
        delegate?.navigationController?.popViewController(animated: true)
    }
    
    func onMoreButtonClick() {
        drawerController?.openSide(.left)
    }
    
    // 타이틀명 변경
    func setAppBarTitle(_ title: String) {
        self.titleBar?.setTitle(title)
    }
}
