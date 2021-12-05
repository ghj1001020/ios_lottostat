//
//  HJNumberTextField.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/02.
//

import UIKit

class HJNumberTextField: HJTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initView()
    }

    func initView() {
        // 숫자키패드 설정
        self.keyboardType = .numberPad
        
        // 확인버튼 추가
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onDone))
        
        let doneToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 50))
        doneToolbar.items = [flexible, doneButton]
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    // 확인버튼
    @objc func onDone() {
        self.resignFirstResponder()
    }
}
