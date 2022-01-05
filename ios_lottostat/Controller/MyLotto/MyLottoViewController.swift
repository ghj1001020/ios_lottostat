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
    private var mMyLottoList : [MyLottoNumber] = []
    
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
        
        
        // 테스트
        let item1 = MyLottoNumber(3, false)
        item1.mLottoList.append(MyLottoData(.DATE, "20220212164030"))
        item1.mLottoList.append(MyLottoData(.LOTTO, "20220212164030", 10, 11, 12, 13, 14, 19))
        item1.mLottoList.append(MyLottoData(.LOTTO, "20220212164030", 20, 21, 22, 23, 24, 29))
        item1.mLottoList.append(MyLottoData(.LOTTO, "20220212164030", 20, 21, 22, 33, 34, 39))
        item1.mLottoList.append(MyLottoData(.LOTTO, "20220212164030", 20, 31, 32, 33, 34, 40))
        item1.mLottoList.append(MyLottoData(.LOTTO, "20220212164030", 20, 41, 42, 43, 44, 45))
        mMyLottoList.append(item1)
        let item2 = MyLottoNumber(2, false)
        item2.mLottoList.append(MyLottoData(.DATE, "30221212164030"))
        item2.mLottoList.append(MyLottoData(.LOTTO, "30221212164030", 10, 11, 12, 13, 14, 19))
        item2.mLottoList.append(MyLottoData(.LOTTO, "30221212164030", 20, 21, 22, 23, 24, 29))
        item2.mLottoList.append(MyLottoData(.LOTTO, "30221212164030", 20, 21, 22, 33, 34, 39))
        item2.mLottoList.append(MyLottoData(.LOTTO, "30221212164030", 20, 31, 32, 33, 34, 40))
        item2.mLottoList.append(MyLottoData(.LOTTO, "30221212164030", 20, 41, 42, 43, 44, 45))
        mMyLottoList.append(item2)
        let item3 = MyLottoNumber(1, false)
        item3.mLottoList.append(MyLottoData(.DATE, "20220102164030"))
        item3.mLottoList.append(MyLottoData(.LOTTO, "20220102164030", 10, 11, 12, 13, 14, 19))
        item3.mLottoList.append(MyLottoData(.LOTTO, "20220102164030", 20, 21, 22, 23, 24, 29))
        item3.mLottoList.append(MyLottoData(.LOTTO, "20220102164030", 20, 21, 22, 33, 34, 39))
        mMyLottoList.append(item3)
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
            cell.backgroundColor = ColorUtil.uiColorByRGB(rgb: "#f0eeed")
            return cell
        }
        // 로또번호 셀
        else if data.type == .LOTTO {
            guard var cell = tableView.dequeueReusableCell(withIdentifier: "myLottoNumberCell") as? ItemMyLottoNumber else {
                return UITableViewCell()
            }
            
            // 디바이더
            cell.divider.isHidden = indexPath.row == mMyLottoList[indexPath.section].mLottoList.count - 1 ? true : false
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

