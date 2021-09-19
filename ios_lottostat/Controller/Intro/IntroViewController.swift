//
//  IntroViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/11.
//

import UIKit
import FirebaseFirestore

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
        let dialog = AlertUtil.alert()
        dialog.frame = self.view.bounds
        self.view.addSubview(dialog)
                
        lbMessage.text = "앱 버전정보를 가져옵니다"
        let db = Firestore.firestore()
        db.collection("app").document("appinfo").getDocument { (querySnapshot: DocumentSnapshot?, error: Error?) in
            // 성공
            if let querySnapshot = querySnapshot {
                if( querySnapshot.get("version") is String ) {
                    let version = querySnapshot.get("version") as! String
                    LogUtil.p(version)
                    
                    // 낮은버전이면 업데이트 팝업 노출
                }
            }
            // 실패
            else if let error = error {
                
            }
        }
    }
}
