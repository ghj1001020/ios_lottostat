//
//  BaseDialog.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/19.
//

import Foundation
import UIKit

class BaseDialog: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let className = String(describing: type(of: self))
        guard let nibView = UINib(nibName: className, bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? CommonDialog else {
            return
        }
        nibView.frame = self.bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(nibView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
