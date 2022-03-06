//
//  HJCheckImageView.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/06.
//

import Foundation
import UIKit

class HJCheckImageView : UIImageView {
    
    // 체크여부
    private var _isChecked : Bool = false
    @IBInspectable public var isChecked : Bool {
        set {
            _isChecked = newValue
            renderImage()
        }
        get {
            return _isChecked
        }
    }
    @IBInspectable private var imgCheck : UIImage = UIImage()
    @IBInspectable private var imgUncheck : UIImage = UIImage()

    
    func renderImage() {
        self.image = _isChecked ? imgCheck : imgUncheck
    }
}
