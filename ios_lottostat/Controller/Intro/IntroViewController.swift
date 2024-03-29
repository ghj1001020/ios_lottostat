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
    private let INTRO_TIME : Int64 = 1 * 1000
    var mStartTime : Int64!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mStartTime = Date().toMilliSeconds()
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
                    if( !AppUtil.checkAppVersion(serverVer: version) ) {
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
                        return
                    }
                    // 정상버전이면 로또번호 가져오기
                    self.getLottoNumber()
                    self.createTable()
                }
            }
            // 버전요청 실패
            else if error != nil {
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
    
    // SQLite에서 데이터 읽기
    func getLottoNumber() {
        let copyVersion : Int = DefaultsUtil.shared.getInt(DefineDefaults.VERSION_COPY_SQLITE)
        var isCopy = copyVersion == SQLite.SQLite_VERSION
        if( !isCopy ) {
            lbMessage.text = "데이터 파일을 가져옵니다"
            
            // SQLite 파일 있는지 확인
            let isExist = FileUtil.checkBundleFileExist(SQLite.DB_RESOURCE_FILE_NAME, SQLite.DB_RESOURCE_FILE_EXT)
            
            // SQLite 파일 복사
            if( isExist ) {
                do {
                    let bundleUrl = Bundle.main.url(forResource: SQLite.DB_RESOURCE_FILE_NAME, withExtension: SQLite.DB_RESOURCE_FILE_EXT)
                    let toUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(SQLite.DB_FILE_NAME)
                    isCopy = FileUtil.copyFile(fromUrl: bundleUrl, toUrl: toUrl)
                }
                catch {
                    LogUtil.p(error.localizedDescription)
                }

                if( isCopy ) {
                    DefaultsUtil.shared.put(DefineDefaults.VERSION_COPY_SQLITE, SQLite.SQLite_VERSION)
                }
            }
        }
        
        if( isCopy ) {
            lbMessage.text = "로또 당첨번호를 가져옵니다"
            moveToMain()
        }
        else {
            CommonDialog.instance()
                .setTitle(title: "알림")
                .setMessage(message: "로또당첨번호를 가져오지 못하였습니다.")
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
    
    // 테이블 생성
    func createTable() {
        let dbVersion : Int = DefaultsUtil.shared.getInt(DefineDefaults.DB_VERSION)
        if dbVersion != SQLite.DB_VERSION {
            let isSuccess = SQLiteService.createTable()
            if isSuccess {
                DefaultsUtil.shared.put(DefineDefaults.DB_VERSION, SQLite.DB_VERSION)
            }
        }
    }
    
    // 인트로 로딩
    func moveToMain() {
        lbMessage.text = "메인으로 이동합니다."
        
        let diffTime = Date().toMilliSeconds() - mStartTime
        if( diffTime < INTRO_TIME ) {
            Timer.scheduledTimer(withTimeInterval: Double(INTRO_TIME-diffTime)/1000, repeats: false) { (timer: Timer) in
                self.moveToMainStoryBoard()
            }
        }
        else {
            moveToMainStoryBoard()
        }
    }

    // 메인으로 이동
    func moveToMainStoryBoard() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.setRootViewController(.MAIN)
        }
    }
}
