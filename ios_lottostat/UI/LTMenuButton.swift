//
//  LTMenuButton.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2023/11/05.
//

import Foundation
import UIKit

class LTMenuButton : UIButton {
    
    @IBInspectable var icon: UIImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        contentHorizontalAlignment = .left
        // 텍스트
        setTitleColor(ColorUtil.text(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 왼쪽 아이콘
        setImage(icon, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0 , left: 20, bottom: 0, right: 0);
        imageEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: self.frame.size.width - 36);
        imageView?.tintColor = UIColor.black

        // 밑줄
        let line = UIView(frame: CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1))
        line.backgroundColor = UIColor.black
        addSubview(line)
    }
}
