//
//  LTMenuButton.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2023/11/05.
//

import Foundation
import UIKit

class LTMenuButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        setTitleColor(ColorUtil.text(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    override func layoutSubviews() {
        setImage(UIImage(named: "ic_recommend"), for: .normal)

        titleEdgeInsets = UIEdgeInsets(top: 0 , left: -56, bottom: 0, right: 0);
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 36);
        
        setTitleColor(ColorUtil.text(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
}
