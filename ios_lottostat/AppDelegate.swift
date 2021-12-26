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

    // 앱을 실행할 준비가 되었음
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 파이어베이스 초기화
        FirebaseApp.configure()
                
        return true
    }
    
    public func setRootViewController( root: UIViewController) {
        window?.rootViewController = root
    }
}
