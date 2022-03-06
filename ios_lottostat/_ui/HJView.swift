//
//  HJView.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/06.
//

import Foundation
import UIKit

class HJView : UIView {
    
    var delegate : HJViewEvent? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        let _click = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(sender:)))
        self.addGestureRecognizer(_click)
    }
    

    // 클릭
    @objc func onTapGesture(sender: UITapGestureRecognizer) {
        self.delegate?.onClickEvent(view: self)
    }
}

protocol HJViewEvent {
    func onClickEvent(view: HJView)
}

extension HJViewEvent {
    func onClickEvent(view: HJView) { }
}
