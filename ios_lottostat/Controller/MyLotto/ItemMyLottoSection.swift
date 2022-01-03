//
//  ItemMyLottoSection.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/01/02.
//

import Foundation
import UIKit

class ItemMyLottoSection : UITableViewHeaderFooterView {
    
    @IBOutlet var lbNo: UILabel!
    @IBOutlet var imgArrow: UIImageView!
    
    var delegate : MyLottoProtocol? = nil
    
    var section : Int = 0   // 몇번째 섹션인지 인덱스


    // xib, 스토리보드로 사용
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    func initView() {
        // 클릭이벤트 설정
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onSectionClick))
        addGestureRecognizer(gesture)
    }
    
    @objc func onSectionClick(_ sender: UIView) {
        delegate?.onSectionClick(section)
    }
}
