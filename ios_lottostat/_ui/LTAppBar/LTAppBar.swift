//
//  LTAppBar.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/28.
//

import Foundation
import UIKit


protocol LTAppBarPortocol {
    func onBackButtonClick()
    func onMoreButtonClick()
}


//@IBDesignable
class LTAppBar : UIView {
            
    public var delegate : LTAppBarPortocol? = nil
    
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
        

    // 인스턴스로 사용
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // xib, 스토리보드로 사용
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadXib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else  {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    // 타이틀
    func setTitle(_ title: String?) {
        lbTitle.text = title
    }
    
    // 사이드메뉴
    @IBAction func onMoreButton(_ sender: UIButton) {
        self.delegate?.onMoreButtonClick()
    }
    
    // 뒤로가기
    @IBAction func onBackButton(_ sender: UIButton) {
        self.delegate?.onBackButtonClick()
    }
}
