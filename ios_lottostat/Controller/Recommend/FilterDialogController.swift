//
//  FilterDialogController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/11/04.
//

import UIKit

class FilterDialogController: UIViewController {
    
    private let dim : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    private let bottomSheet : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            view.layer.cornerRadius = 28
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 28, height: 28))
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = view.bounds
            shapeLayer.path = path.cgPath
            view.layer.mask = shapeLayer
        }
        view.clipsToBounds = true
        
        return view
    }()
    
    // 바텀시트 상단높이 제약
    private var bottomSheetTopConstraint : NSLayoutConstraint!
    
    // 바텀시트 높이
    private var defaultHeight : CGFloat = 300
    

    // 뷰가 로드된 후 한번호출
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
    }

    // 로드된 뷰가 화면에 표시될때 마다 호출
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startBottomSheet()
    }

    
    func initLayout() {
        self.view.addSubview(dim)
        self.view.addSubview(bottomSheet)
        
        // 딤영역
        dim.translatesAutoresizingMaskIntoConstraints = false // 자동레이아웃을 사용하여 뷰의크기와 위치를 동적으로 계산
        dim.alpha = 0.0
        NSLayoutConstraint.activate([
            dim.topAnchor.constraint(equalTo: self.view.topAnchor) ,
            dim.leadingAnchor.constraint(equalTo: self.view.leadingAnchor) ,
            dim.trailingAnchor.constraint(equalTo: self.view.trailingAnchor) ,
            dim.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        let dimTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureDimTapped(_:)) )
        dim.addGestureRecognizer(dimTapRecognizer)
        dim.isUserInteractionEnabled = true
        
        // 바텀시트 영역
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        var topHeight : CGFloat = self.view.frame.height;
        if #available(iOS 11.0, *) {
            topHeight = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height
        }
        bottomSheetTopConstraint = bottomSheet.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topHeight)
        NSLayoutConstraint.activate([
            bottomSheetTopConstraint ,
            bottomSheet.leadingAnchor.constraint(equalTo: self.view.leadingAnchor) ,
            bottomSheet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor) ,
            bottomSheet.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    // 바텀시트 열기 애니메이션
    func startBottomSheet() {
        var topHeight = self.view.frame.height - defaultHeight
        if #available(iOS 11.0, *) {
            topHeight = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height - defaultHeight
        }
        bottomSheetTopConstraint.constant = topHeight
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.dim.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func gestureDimTapped(_ recognizer: UITapGestureRecognizer) {
        endBottomSheet()
    }
    
    // 바텀시트 닫기 애니메이션
    func endBottomSheet() {
        var topHeight = self.view.frame.height
        if #available(iOS 11.0, *) {
            topHeight = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height
        }
        bottomSheetTopConstraint.constant = topHeight
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) {
            self.dim.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { (isComplete : Bool) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
