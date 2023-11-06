//
//  LTGradientButton.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/02.
//

import Foundation
import UIKit

class LTGradientButton : UIButton {
    
    @IBInspectable var color1 : UIColor = UIColor.clear
    @IBInspectable var color2 : UIColor = UIColor.clear
    @IBInspectable var color3 : UIColor = UIColor.clear
    @IBInspectable var horizontal : Bool = true
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }

    
    // 그라디언트 배경색 설정
    func setGradientBackground() {
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        
        var arrColor : [CGColor] = []
        if( color1 != UIColor.clear ) {
            arrColor.append(color1.cgColor)
        }
        if( color2 != UIColor.clear ) {
            arrColor.append(color2.cgColor)
        }
        if( color3 != UIColor.clear ) {
            arrColor.append(color3.cgColor)
        }
        
        let arrLocations : [NSNumber] = arrColor.count == 3 ? [0.0, 0.5, 1.0] : [0.0, 1.0]
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = arrColor
        gradientLayer.locations = arrLocations
        if( horizontal ) {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
        else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
