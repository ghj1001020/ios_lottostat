//
//  HJLabel.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/05.
//

import UIKit

class HJLabel: UILabel {

    // 패딩
    @IBInspectable var topPadding : CGFloat = 0
    @IBInspectable var bottomPadding : CGFloat = 0
    @IBInspectable var leftPadding : CGFloat = 0
    @IBInspectable var rightPadding : CGFloat = 0
    var edgeInsets : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    // 불릿
    private let bullet = "• "
    @IBInspectable var isBullet : Bool = false
    
    // 텍스트
    override var text: String? {
        didSet(value) {
            setText(newVal: value)
        }
    }

    var content : String = ""
    
    // 글자 세팅
    func setText(newVal: String?) {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        edgeInsets = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        
        if( isBullet ) {
            addBullet()
        }
    }
    
    func initView() {
        content = self.text ?? ""
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    // 뷰의 속성만을 고려한 뷰자체의 고유크기
    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += edgeInsets.left + edgeInsets.right
        intrinsicContentSize.height += edgeInsets.top + edgeInsets.bottom
        return intrinsicContentSize
    }
    
    // 불릿 추가
    func addBullet() {
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        
        let string = bullet + content
        self.attributedText = NSAttributedString(string: string, attributes: attributes)
    }
}
