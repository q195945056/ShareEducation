//
//  MonthViewController.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class MonthViewController: UIViewController {
    
    var month: Date {
        didSet {
            updateData()
        }
    }
    
    var size: CGSize {
        get {
            let rowCount = days.count / 7
            let itemWidth = (collectionView.frame.width - 26 - 29 * 6) / 7
            let itemHeight = itemWidth + 8
            let height = CGFloat(rowCount) * itemHeight + (CGFloat(rowCount) - 1) * 10
            return CGSize(width: view.bounds.width, height: height.ylCeil + 40)
        }
    }
    
    var days = [Date]()
    
    init(month: Date) {
        self.month = month
        super.init(nibName: nil, bundle: nil)
        updateData()
    }
    
    required init?(coder: NSCoder) {
        month = Date()
        super.init(coder: coder)
        updateData()
    }
    
    lazy var headerView: WeekHeaderView = {
        let headerView = WeekHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
        return headerView
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        layout.minimumInteritemSpacing = 29
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func updateData() {
        let firstDayInMonth = month.dateAt(.startOfMonth)
        let firstDayInWeek = firstDayInMonth.dateAt(.startOfWeek)
        let weekday = firstDayInMonth.weekday
        let previousMonthDayCount = (weekday + 7 - firstDayInWeek.weekday) % 7
        let dayCountInMonth = month.monthDays
        print(dayCountInMonth)
        let rowCount = (previousMonthDayCount + dayCountInMonth) / 7 + ((previousMonthDayCount + dayCountInMonth) % 7 > 0 ? 1 : 0)
        let dayCount = rowCount * 7
        for i in 0...dayCount {
            var dateComponents = DateComponents()
            dateComponents.day = i
            let date = firstDayInWeek + dateComponents
            days.append(date)
        }
        collectionView.reloadData()
    }
    
    func setupUI() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
        headerView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(view)
            make.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(500)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        let date = days[indexPath.item]
        cell.date = days[indexPath.item]
        cell.isHidden = date.month != month.month

        return cell
    }
}

extension MonthViewController: UICollectionViewDelegate {
    
}

extension MonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 26 - 29 * 6) / 7
        let height = width + 8
        return CGSize(width: floor(width), height: height)
    }
}
