//
//  LTHorizontalLoadingView.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/11.
//

import UIKit

class LTHorizontalLoadingView: UIProgressView {
    
    var isStart : Bool = false
    var isFull : Bool = false

    private func animate() {
        if( !isStart ) {
            return
        }
        
        // 로딩바 애니메이션
        UIView.animate(withDuration: 0.7) {
            self.setProgress(self.isFull ? 1 : 0, animated: true)
        } completion: { (isFinish: Bool) in
            self.isFull = !self.isFull
        }
        
        // 반복
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.animate()
        }
    }
    
    public func startAnimation() {
        self.isStart = true
        self.isFull = true
        // 반복
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animate()
        }
    }
    
    public func stopAnimation() {
        self.isStart = false
        self.isFull = false
    }
}
