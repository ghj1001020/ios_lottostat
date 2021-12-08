//
//  HJCheckBox.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/17.
//

import UIKit

class HJCheckBox: UIButton {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc func onClick() {
        isChecked = !isChecked
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        renderImage()
    }
    
    func renderImage() {
        // 이미지 위치
//        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//        self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//        self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                
        if( _isChecked ) {
            self.setImage(imgCheck, for: .normal)
        }
        else {
            self.setImage(imgUncheck, for: .normal)
        }
    }

}
