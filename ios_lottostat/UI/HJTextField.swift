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
    // border
    @IBInspectable var borderTop : Bool = false
    @IBInspectable var borderLeft : Bool = false
    @IBInspectable var borderBottom : Bool = false
    @IBInspectable var borderRight : Bool = false
    @IBInspectable var borderWidth : CGFloat = 1
    @IBInspectable var borderColor : UIColor = UIColor.black
    

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
        
        updateBorder()
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
    
    // border rendering
    func updateBorder() {
        LogUtil.p("\(frame.minX), \(frame.maxX), \(frame.minY), \(frame.maxY), \(frame.width), \(frame.height)")
        
        if( borderTop ) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = borderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
            
            self.layer.addSublayer(borderLayer)
        }
        if( borderBottom ) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = borderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: borderWidth)
            
            self.layer.addSublayer(borderLayer)
        }
        if( borderLeft ) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = borderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.height)
            
            self.layer.addSublayer(borderLayer)
        }
        if( borderRight ) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = borderColor.cgColor
            borderLayer.frame = CGRect(x: frame.width, y: 0, width: borderWidth, height: frame.height)
            
            self.layer.addSublayer(borderLayer)
        }
    }
}
