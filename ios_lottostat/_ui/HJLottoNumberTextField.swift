//
//  HJLottoNumberTextField.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/11.
//

import UIKit

class HJLottoNumberTextField: HJNumberTextField {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initView()
    }

    
}
