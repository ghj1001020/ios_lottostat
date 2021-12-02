//
//  HJTextField.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/01.
//

import UIKit

class HJTextField: UITextField , UITextFieldDelegate {
    
    // 최대글자수
    @IBInspectable var maxLength : Int = -1
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // 글자 변경리스너
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        return newLength <= maxLength
    }
    
    // 엔터입력 리스너
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
