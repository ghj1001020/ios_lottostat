//
//  IntroViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/11.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet var loadingBar: LTHorizontalLoadingView!
    @IBOutlet var lbMessage: UILabel!
    
    // 최소 로딩시간
    var mStartTime = Date().toMilliSeconds()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingBar.startAnimation()
        
        requestAppVersion()
    }
    
    // 최신 버전요청
    func requestAppVersion() {
        lbMessage.text = "앱 버전정보를 가져옵니다"
    }
}
