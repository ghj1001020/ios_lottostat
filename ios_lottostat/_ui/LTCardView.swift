//
//  LTCardView.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/19.
//

import Foundation
import UIKit


class LTCardView : UIView {
    @IBInspectable public var corners : Bool = false
    @IBInspectable public var radius : CGFloat = 3
    @IBInspectable public var topLeftCorner : Bool = false
    @IBInspectable public var topRightCorner : Bool = false
    @IBInspectable public var bottomLeftCorner : Bool = false
    @IBInspectable public var bottomRightCorner : Bool = false

    override func layoutSubviews() {
        
        // 라운드
        if #available(iOS 11.0, *) {
            updateCornerRound()
        }
        else {
            updateCornerRoundOld()
        }
        
        // 선색
    }
    
    // 라운드 11이상 버전
    @available(iOS 11.0, *)
    func updateCornerRound() {
        clipsToBounds = true

        var maskLayer = CACornerMask()
        if corners || topLeftCorner {
            maskLayer.formUnion(.layerMinXMinYCorner)
        }
        if corners || topRightCorner {
            maskLayer.formUnion(.layerMaxXMinYCorner)
        }
        if corners || bottomLeftCorner {
            maskLayer.formUnion(.layerMinXMaxYCorner)
        }
        if corners || bottomRightCorner {
            maskLayer.formUnion(.layerMaxXMaxYCorner)
        }
        layer.maskedCorners = maskLayer
        layer.cornerRadius = radius
    }
    
    // 라운드 올드버전
    func updateCornerRoundOld() {
        var rectCorner = UIRectCorner()
        if corners || topLeftCorner {
            rectCorner.formUnion(.topLeft)
        }
        if corners || topRightCorner {
            rectCorner.formUnion(.topRight)
        }
        if corners || bottomLeftCorner {
            rectCorner.formUnion(.bottomLeft)
        }
        if corners || bottomRightCorner {
            rectCorner.formUnion(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
