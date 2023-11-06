//
//  AppDelegate.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/08.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    let LottoWinNumberList : [LottoWinNumber] = SQLiteService.selectLottoWinNumber()
    

    // 앱을 실행할 준비가 되었음
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 파이어베이스 초기화
        FirebaseApp.configure()
        
        self.window = UIWindow()
        setRootViewController(.INTRO)
                
        return true
    }
    
    // 루트뷰 설정
    public func setRootViewController(_ type: ROOT) {
        var controller : UIViewController
        // 인트로
        if(type == ROOT.INTRO ) {
            controller = AppUtil.GetUIViewController("IntroViewController", "intro")
        }
        // 메인
        else{
            controller = AppUtil.GetUIViewController("MainViewController", "main")
        }
                
        // 루트뷰 설정
        self.navigationController = UINavigationController(rootViewController: controller)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}

enum ROOT {
    case INTRO
    case MAIN
}
