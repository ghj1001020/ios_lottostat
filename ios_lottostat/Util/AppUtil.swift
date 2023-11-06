//
//  AppUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/20.
//

import Foundation
import UIKit

class AppUtil {
    
    // 앱 최신버전 비교
    public static func checkAppVersion(serverVer: String) -> Bool {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return false
        }
        
        let arrVersion = version.components(separatedBy: ".")
        let arrServerVer = serverVer.components(separatedBy: ".")
        for (index, item) in arrVersion.enumerated() {
            if( index >= arrServerVer.count ) {
                return false
            }
            
            let server = Int(arrServerVer[index]) ?? 0
            let app = Int(item) ?? 0
            // 앱버전 코드가 높으면 최신버전
            if( app > server ) {
                return true
            }
            // 서버버전코드가 높으면 낮은버전
            else if(app < server) {
                return false
            }
        }
        
        return true
    }
    
    // 스토리보드 뷰컨트롤러 이동
    public static func GetUIViewController(_ storyboard: String, _ identifier: String, _ bundle: Bundle?=nil) -> UIViewController {
        let storyboard : UIStoryboard = UIStoryboard(name: storyboard, bundle: bundle)
        var controller : UIViewController
        if #available(iOS 13.0, *) {
            controller = storyboard.instantiateViewController(identifier: identifier)
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: identifier)
        }
        controller.modalPresentationStyle = .fullScreen

        return controller
    }
}
