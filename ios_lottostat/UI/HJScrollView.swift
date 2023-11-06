//
//  HJView.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/17.
//

import UIKit

class HJScrollView: UIScrollView {

    // 라운드
    @IBInspectable public var cornerTopLeft : Bool = false
    @IBInspectable public var cornerTopRight : Bool = false
    @IBInspectable public var cornerBottomLeft : Bool = false
    @IBInspectable public var cornerBottomRight : Bool = false
    @IBInspectable public var cornerRadius : CGFloat = 0
    
    // 선색
    @IBInspectable public var borderColor : UIColor = UIColor.clear
    
    // 패딩
    @IBInspectable public var paddingLeft : CGFloat = 0
    @IBInspectable public var paddingRight : CGFloat = 0
    @IBInspectable public var paddingTop : CGFloat = 0
    @IBInspectable public var paddingBottom : CGFloat = 0

    
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 라운드 마스크
        if #available(iOS 11.0, *) {
            updateCornerRound()
        }
        else {
            updateCornerRoundOld()
        }
        
        // 선색
        layer.borderColor = borderColor.cgColor
        
        // 패딩
//        self.frame.insetBy(dx: 16, dy: 0)
//        if #available(iOS 11.0, *) {
//            self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: paddingTop, leading: paddingLeft, bottom: paddingBottom, trailing: paddingRight)
//        }
//        else {
//        self.bounds = self.frame.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight))
//        self.contentInset = UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: 0)
//        }
        
    }
    
    // 라운드
    func updateCornerRoundOld() {
        var options = UIRectCorner()
        if cornerTopLeft {
            options.formUnion(.topLeft)
        }
        if cornerTopRight {
            options.formUnion(.topRight)
        }
        if cornerBottomLeft {
            options.formUnion(.bottomLeft)
        }
        if cornerBottomRight {
            options.formUnion(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: options, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    // 라운드
    @available(iOS 11.0, *)
    func updateCornerRound() {
        var maskLayer = CACornerMask()
        if cornerTopLeft {
            maskLayer.formUnion(.layerMinXMinYCorner)
        }
        if cornerTopRight {
            maskLayer.formUnion(.layerMaxXMinYCorner)
        }
        if cornerBottomLeft {
            maskLayer.formUnion(.layerMinXMaxYCorner)
        }
        if cornerBottomRight {
            maskLayer.formUnion(.layerMaxXMaxYCorner)
        }
        
        layer.maskedCorners = maskLayer
        layer.cornerRadius = cornerRadius
    }

}
