//
//  AlertUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/19.
//

import Foundation
import UIKit

class AlertUtil {
    
    static func alert() -> CommonDialog {
        let dialog = UINib(nibName: "CommonDialog", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CommonDialog
        
        return dialog
    }
}
