//
//  IntroViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/11.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet var loadingBar: LTHorizontalLoadingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingBar.startAnimation()
    }
}
