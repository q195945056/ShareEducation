//
//  MonthViewController.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate

class CalendarViewController: UIViewController {
    
    enum CalendarType {
        case month
        case week
    }
    
    var type: CalendarType = .month
    
    var date: Date {
        didSet {
            updateData()
        }
    }
    
    var nextDate: Date {
        var dateComponents = DateComponents()
        switch type {
        case .month:
            dateComponents.month = 1
        case .week:
            dateComponents.day = 7
        }
        return date + dateComponents
    }
    
    var previousDate: Date {
        var dateComponents = DateComponents()
        switch type {
        case .month:
            dateComponents.month = 1
        case .week:
            dateComponents.day = 7
        }
        return date - dateComponents
    }
    
    var size: CGSize {
        get {
            var rowCount = 1
            if type == .month {
                rowCount = days.count / 7
            }
            let itemWidth = (view.frame.width - 26 - 29 * 6) / 7
            let itemHeight = itemWidth + 8
            let height = CGFloat(rowCount) * itemHeight + (CGFloat(rowCount) - 1) * 10
            return CGSize(width: view.bounds.width, height: height.ylCeil + 40 + 8)
        }
    }
    
    var days = [Date]()
    
    init(type: CalendarType = .month, date: Date) {
        self.type = type
        self.date = date
        super.init(nibName: nil, bundle: nil)
        updateData()
    }
    
    required init?(coder: NSCoder) {
        date = Date()
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
        switch type {
        case .month:
            let firstDayInMonth = date.dateAt(.startOfMonth)
            let firstDayInWeek = firstDayInMonth.dateAt(.startOfWeek)
            let weekday = firstDayInMonth.weekday
            let previousMonthDayCount = (weekday + 7 - firstDayInWeek.weekday) % 7
            let dayCountInMonth = date.monthDays
            print(dayCountInMonth)
            let rowCount = (previousMonthDayCount + dayCountInMonth) / 7 + ((previousMonthDayCount + dayCountInMonth) % 7 > 0 ? 1 : 0)
            let dayCount = rowCount * 7
            for i in 0...dayCount {
                var dateComponents = DateComponents()
                dateComponents.day = i
                let date = firstDayInWeek + dateComponents
                days.append(date)
            }
        case .week:
            let firstDayInWeek = date.dateAt(.startOfWeek)
            for i in 0...7 {
                var dateComponents = DateComponents()
                dateComponents.day = i
                let date = firstDayInWeek + dateComponents
                days.append(date)
            }
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

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        let date = days[indexPath.item]
        cell.date = days[indexPath.item]
        if type == .month {
            cell.isHidden = date.month != date.month
        }
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 26 - 29 * 6) / 7
        let height = width + 8
        return CGSize(width: width.ylFloor, height: height.ylCeil)
    }
}
