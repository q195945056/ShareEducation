//
//  WeekHeaderView.swift
//  Calendar
//
//  Created by 严明俊 on 2019/12/16.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SwiftDate
import SnapKit

class WeekHeaderView: UIView {
    
    var titles = [String]()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        layout.minimumInteritemSpacing = 29
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeekTitleCell.self, forCellWithReuseIdentifier: "WeekTitleCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .clear
        var calendar = Calendar.Identifier.gregorian.toCalendar()
        calendar.locale = Locales.chinese.toLocale()
        let firstWeekday = calendar.firstWeekday
        let weekSymbols = calendar.veryShortWeekdaySymbols
        for i in 0...6 {
            let index = firstWeekday + i
            let symbolString = weekSymbols[index - 1]
            titles.append(symbolString)
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        collectionView.reloadData()
    }
}

extension WeekHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekTitleCell", for: indexPath) as! WeekTitleCell
        cell.titleLabel.text = titles[indexPath.item]
        return cell
    }
}

extension WeekHeaderView: UICollectionViewDelegate {
    
}

extension WeekHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 26 - 29 * 6) / 7
        let height = collectionView.frame.height
        return CGSize(width: floor(width), height: height)
    }
}

class WeekTitleCell: UICollectionViewCell {
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    
}
