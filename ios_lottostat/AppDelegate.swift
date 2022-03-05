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
    var LottoWinNumberList : [LottoWinNumber] = SQLiteService.selectLottoWinNumber()
    

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
        var controller : UIViewController? = nil
        
        if( type == ROOT.INTRO ) {
            let storyboard : UIStoryboard = UIStoryboard(name: "IntroViewController", bundle: nil)
            if #available(iOS 13.0, *) {
                controller = storyboard.instantiateViewController(identifier: "intro")
            }
            else {
                controller = storyboard.instantiateViewController(withIdentifier: "intro") as? IntroViewController
            }
        }
        else if( type == ROOT.MAIN ) {
            let storyboard : UIStoryboard = UIStoryboard(name: "MainViewController", bundle: nil)
            if #available(iOS 13.0, *) {
                controller = storyboard.instantiateViewController(identifier: "main")
            }
            else {
                controller = storyboard.instantiateViewController(withIdentifier: "main") as? MainViewController
            }
        }
        
        if let controller = controller {
            controller.modalPresentationStyle = .fullScreen
            self.navigationController = UINavigationController(rootViewController: controller)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.window?.rootViewController = self.navigationController
            self.window?.makeKeyAndVisible()
        }
    }
}

enum ROOT {
    case INTRO
    case MAIN
}
