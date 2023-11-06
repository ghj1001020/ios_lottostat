//
//  HJPlusIcon.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/03/01.
//

import Foundation
import UIKit

class HJPlusIcon : UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.frame.width/2-2, y: self.frame.height/2-6.5))
        path.addLine(to: CGPoint(x: self.frame.width/2+2, y: self.frame.height/2-6.5))
        path.addLine(to: CGPoint(x: self.frame.width/2+2, y: self.frame.height/2+6.5))
        path.addLine(to: CGPoint(x: self.frame.width/2-2, y: self.frame.height/2+6.5))
        path.addLine(to: CGPoint(x: self.frame.width/2-2, y: self.frame.height/2-6.5))
        
        path.move(to: CGPoint(x: self.frame.width/2-6.5, y: self.frame.height/2-2))
        path.addLine(to: CGPoint(x: self.frame.width/2+6.5, y: self.frame.height/2-2))
        path.addLine(to: CGPoint(x: self.frame.width/2+6.5, y: self.frame.height/2+2))
        path.addLine(to: CGPoint(x: self.frame.width/2-6.5, y: self.frame.height/2+2))
        path.addLine(to: CGPoint(x: self.frame.width/2-6.5, y: self.frame.height/2-2))
        
        // 배경
        ColorUtil.colorByString(rgb: "#31AEA9").setFill()
        path.fill()
    }
}
