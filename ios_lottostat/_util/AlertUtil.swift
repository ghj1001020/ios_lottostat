//
//  AlertUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2022/01/06.
//

import Foundation
import UIKit

class AlertUtil {    
    
    public class Alert {
        var controller : UIViewController
        var title : String = ""
        var message : String = ""
        var positiveText : String? = nil
        var negativeText : String? = nil
        var positiveDelegate : (()->Void)? = nil
        var negativeDelegate : (()->Void)? = nil

        
        init(_ controller: UIViewController, _ title: String?="", _ message: String?="") {
            self.controller = controller
            self.title = title ?? ""
            self.message = message ?? ""
        }
        
        func setTitle(_ text: String) {
            self.title = text
        }
        
        func setMessage(_ text: String) {
            self.message = text
        }
        
        func setPositive(_ text: String="확인", _ delegate: (()->Void)?=nil) {
            self.positiveText = text
            self.positiveDelegate = delegate
        }
        
        func setNegative(_ text: String="취소", _ delegate: (()->Void)?=nil) {
            self.negativeText = text
            self.negativeDelegate = delegate
        }
        
        func show() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if( negativeText != nil) {
                let action = UIAlertAction(title: negativeText, style: .cancel) { (action: UIAlertAction) in
                    if let callback = self.negativeDelegate {
                        callback()
                    }
                }
                alert.addAction(action)
            }
            
            if(positiveText != nil) {
                let action = UIAlertAction(title: positiveText, style: .default) { (action: UIAlertAction) in
                    if let callback = self.positiveDelegate {
                        callback()
                    }
                }
                alert.addAction(action)
            }
            
            if(negativeText == nil && positiveText == nil) {
                let action = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
            }
            
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
