//
//  CommonDialog.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/18.
//

import Foundation
import UIKit


class CommonDialog : UIView {

    public static var PositiveAction = 0
    public static var NegativeAction = 1
    

    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbMessage: UILabel!
    @IBOutlet var crMessageTop: NSLayoutConstraint!
    
    // root
    var root : UIView? = nil
    // protocol
    var callback : ((_: Int)->Void)? = nil
    
    
    public func show(_ root: UIView) {
        self.root = root
        self.frame = root.bounds
        root.addSubview(self)
    }
    
    @IBAction func onPositiveListener(_ sender: UIButton) {
        removeFromSuperview()
        callback?(CommonDialog.PositiveAction)
    }
    
    // 타이틀
    public func setTitle(title: String) -> CommonDialog {
        lbTitle.text = title
        lbTitle.isHidden = false
        crMessageTop.constant = 56
        return self
    }
    
    // 메시지
    public func setMessage(message: String) -> CommonDialog {
        lbMessage.text = message
        return self
    }
    
    // 리스너
    public func setDelegate(delegate: @escaping ((_: Int)->Void)) -> CommonDialog {
        self.callback = delegate
        return self
    }
    
    
    static func instance() -> CommonDialog {        
        guard let nibView = UINib(nibName: "CommonDialog", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? CommonDialog else {
            return CommonDialog()
        }
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return nibView
    }
}
