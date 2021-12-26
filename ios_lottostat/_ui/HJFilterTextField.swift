//
//  HJFilterTextField.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/11.
//

import UIKit

class HJFilterTextField: HJNumberTextField {

    var mCurrentNumber: Int = 0
    var minNum : Int = 0
    var maxNum : Int = 6
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initView()
    }
    
    private func initView() {
        self.isEnabled = false
        mCurrentNumber = StringUtil.convertToInt(self.text)
    }
    
    func setNumber(num: Int) {
        if( minNum <= num && num <= maxNum ) {
            mCurrentNumber = num
        }
        self.text = String(mCurrentNumber)
    }
    
    func add(num: Int=1) {
        setNumber(num: mCurrentNumber + num)
    }
    
    func minus(num: Int=1) {
        setNumber(num: mCurrentNumber - num)
    }
    
    func setMinNumber(num: Int) {
        minNum = num
    }
    
    func setMaxNumber(num: Int) {
        maxNum = num
    }
}
