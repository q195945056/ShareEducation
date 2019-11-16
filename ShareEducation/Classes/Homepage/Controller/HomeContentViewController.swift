//
//  HomeContentViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/9.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import TYCyclePagerView
import SnapKit
import Then

class HomeContentViewController: BaseContentViewController {
    
    @IBOutlet var tableView: UITableView!
    
    lazy var bannerDatas = [UIColor]()
    
    lazy var pagerView: TYCyclePagerView = TYCyclePagerView().then { pagerView in
        let bannerCellWidth = UIScreen.main.bounds.width - 26
        let bannerCellHeight = bannerCellWidth * 140 / 349
        pagerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: bannerCellHeight + 25)
        pagerView.isInfiniteLoop = true
        pagerView.autoScrollInterval = 3.0
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(HomeBannerCell.classForCoder(), forCellWithReuseIdentifier: HomeBannerCell.reuseIdentifier)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupUI()
        
        _loadData()
    }
    

    
    // MARK: - Private Methods
    
    func _setupUI() -> Void {
        
        tableView.sectionHeaderHeight = 50
        tableView.register(HomeSetionTitleView.self, forHeaderFooterViewReuseIdentifier: HomeSetionTitleView.reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.tableHeaderView = pagerView
    }

    func _loadData() {
        var i = 0
        while i < 5 {
            self.bannerDatas.append(UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1))
            i += 1
        }
        self.pagerView.reloadData()
    }
}

extension HomeContentViewController: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    
    // MARK: TYCyclePagerViewDataSource
    
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return self.bannerDatas.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.reuseIdentifier, for: index) as! HomeBannerCell
        cell.imageView.backgroundColor = self.bannerDatas[index]
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let bannerCellWidth = UIScreen.main.bounds.width - 26
        let bannerCellHeight = bannerCellWidth * 140 / 349
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: bannerCellWidth, height: bannerCellHeight)
        layout.itemSpacing = 7
        layout.itemVerticalCenter = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
//        self.pageControl.currentPage = toIndex;
    }
}

extension HomeContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTeacherTableCell.reuseIdentifier, for: indexPath) as! HomeTeacherTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeClassCell.reuseIdentifier, for: indexPath) as! HomeClassCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSetionTitleView.reuseIdentifier) as! HomeSetionTitleView
        sectionHeaderView.titleLabel.text = "明星老师"
        return sectionHeaderView
    }
}

extension HomeContentViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return HomeTeacherTableCell.cellHeight
//        } else {
//            return HomeTeacherTableCell.cellHeight
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
