//
//  MyLottoViewController.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/12/26.
//

import UIKit

protocol MyLottoProtocol {
    // 섹션클릭
    func onSectionClick(_ section: Int)
}

class MyLottoViewController: BaseController {
    
    // My로또 데이터
    private var mMyLottoList : [MyLottoNumber] = {
        return SQLiteService.selectMyLottoRoundNo()
    }()
    
    @IBOutlet var tblMyLotto: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBar(.BACK)
        setAppBarTitle("My로또번호")
        
        // My로또 테이블뷰
        // 섹션 nib
        let nibSection = UINib(nibName: "ItemMyLottoSection", bundle: nil)
        tblMyLotto.register(nibSection, forHeaderFooterViewReuseIdentifier: "myLottoSection")
        // 섹션높이
        tblMyLotto.sectionHeaderHeight = UITableView.automaticDimension
        tblMyLotto.estimatedSectionHeaderHeight = 48
        // 푸터높이 0
        tblMyLotto.sectionFooterHeight = 0
        tblMyLotto.estimatedSectionFooterHeight = 0
        // 비어있는 셀의 divider 제거
        tblMyLotto.tableFooterView = UIView()
        // 셀 nib
        let nibDateCell = UINib(nibName: "ItemMyLottoDate", bundle: nil)
        tblMyLotto.register(nibDateCell, forCellReuseIdentifier: "myLottoDateCell")
        let nibNumberCell = UINib(nibName: "ItemMyLottoNumber", bundle: nil)
        tblMyLotto.register(nibNumberCell, forCellReuseIdentifier: "myLottoNumberCell")
        // 셀높이
        tblMyLotto.rowHeight = UITableView.automaticDimension
    }
}

extension MyLottoViewController : UITableViewDelegate, UITableViewDataSource, MyLottoProtocol {

    func onSectionClick(_ section: Int) {
        mMyLottoList[section].type = mMyLottoList[section].type == .SECT_OPEN ? .SECT_CLOSE : .SECT_OPEN
        tblMyLotto.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mMyLottoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mMyLottoList[section].type == .SECT_OPEN ? mMyLottoList[section].mLottoList.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myLottoSection") as? ItemMyLottoSection else {
            return UITableViewHeaderFooterView()
        }
        
        let myLotto = mMyLottoList[section]
        sectionView.section = section
        sectionView.delegate = self
        sectionView.lbNo.text = "\(myLotto.no)회"
        sectionView.imgArrow.image = myLotto.type == .SECT_OPEN ? UIImage(named: "ic_arrow_u") : UIImage(named: "ic_arrow_d")
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data : MyLottoData = mMyLottoList[indexPath.section].mLottoList[indexPath.row]
        
        // 날짜 셀
        if data.type == .DATE {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myLottoDateCell") as? ItemMyLottoDate else {
                return UITableViewCell()
            }
            cell.lbDate.text = data.regDate.convertDateFormat("yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss")
            return cell
        }
        // 로또번호 셀
        else if data.type == .LOTTO {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myLottoNumberCell") as? ItemMyLottoNumber else {
                return UITableViewCell()
            }
            
            cell.number1.text = "\(data.numnber1)"
            cell.number2.text = "\(data.numnber2)"
            cell.number3.text = "\(data.numnber3)"
            cell.number4.text = "\(data.numnber4)"
            cell.number5.text = "\(data.numnber5)"
            cell.number6.text = "\(data.numnber6)"
            
            // 디바이더
            cell.divider.isHidden = indexPath.row == mMyLottoList[indexPath.section].mLottoList.count - 1 ? true : false
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

