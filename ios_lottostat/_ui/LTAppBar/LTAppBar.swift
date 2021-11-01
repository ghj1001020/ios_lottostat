//
//  LTAppBar.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/28.
//

import Foundation
import UIKit


protocol LTAppBarPortocol {
    func onLeftButtonClick()
}


//@IBDesignable
class LTAppBar : UIView {
            
    public var delegate : LTAppBarPortocol? = nil
    
    @IBOutlet var lbTitle: UILabel!
    

    // 인스턴스로 사용
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }

    // xib, 스토리보드로 사용
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    func loadXib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else  {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setTitle(_ title: String?) {
        lbTitle.text = title
    }

    @IBAction func onLeftButton(_ sender: UIButton) {
        self.delegate?.onLeftButtonClick()
    }
}