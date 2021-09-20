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
                            
        lbMessage.text = "앱 버전정보를 가져옵니다"
        let db = Firestore.firestore()
        db.collection("app").document("appinfo").getDocument { (querySnapshot: DocumentSnapshot?, error: Error?) in
            // 성공
            if let querySnapshot = querySnapshot {
                if( querySnapshot.get("version") is String ) {
                    let version = querySnapshot.get("version") as! String
                    LogUtil.p(version)
                    
                    guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                        return
                    }
                    
                    
                    // 낮은버전이면 업데이트 팝업 노출
                    CommonDialog.instance()
                        .setTitle(title: "App 업데이트 안내")
                        .setMessage(message: "최신버전으로 업데이트 해주세요.")
                        .setDelegate(delegate: { (action: Int) in
                            // 앱종료
                            if( action == CommonDialog.PositiveAction ) {
                                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                exit(0)
                            }
                        })
                        .show(self.view)
                }
            }
            // 버전요청 실패
            else if let error = error {
                CommonDialog.instance()
                    .setMessage(message: "버전정보를 가져오지 못하였습니다.")
                    .setDelegate(delegate: { (action: Int) in
                        // 앱종료
                        if( action == CommonDialog.PositiveAction ) {
                            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                            exit(0)
                        }
                    })
                    .show(self.view)
            }
        }
    }
}
