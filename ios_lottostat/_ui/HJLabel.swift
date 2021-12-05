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
        
        self.text
        
        let bullet = "• "
                
        var strings = [String]()
        strings.append("Payment will be charged to your iTunes account at confirmation of purchase.")
        strings.append("Your subscription will automatically renew unless auto-renew is turned off at least 24-hours before the end of the current subscription period.")
        strings.append("Your account will be charged for renewal within 24-hours prior to the end of the current subscription period.")
        strings.append("Automatic renewals will cost the same price you were originally charged for the subscription.")
        strings.append("You can manage your subscriptions and turn off auto-renewal by going to your Account Settings on the App Store after purchase.")
        strings.append("Read our terms of service and privacy policy for more information.")
        strings = strings.map { return bullet + $0 }
        
        var attributes = [NSAttributedString.Key: Any]()
//        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
//        attributes[.foregroundColor] = UIColor.red
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = strings.joined(separator: "\n\n")
        self.attributedText = NSAttributedString(string: string, attributes: attributes)

    }
    
    func initView() {
        
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
}
