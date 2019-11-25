//
//  YLSegmentedControl.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/3.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class YLSegmentedTitleCell: UICollectionViewCell {
    var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkTextColor
        return label
    }()
    
    var selectedSegmentTintColor: UIColor = .e64919 {
        didSet {
            if isSelected {
                titleLabel.textColor = selectedSegmentTintColor
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
                titleLabel.textColor = selectedSegmentTintColor
            } else {
                titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
                titleLabel.textColor = .darkTextColor
            }
        }
    }
    
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
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-13)
        }
    }
}

class YLSegmentedControl: UIControl {
    
    var items: [String]? {
        didSet {
            collectionView.reloadData()
            if let count = items?.count, count > 0 {
                collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
            }
        }
    }
    
    var numberOfSegments: Int {
        return items?.count ?? 0
    }
    
    var selectedSegmentIndex = 0 {
        willSet {
            guard let items = items, newValue >= 0 && newValue < items.count else {
                return
            }
            collectionView.selectItem(at: IndexPath(item: newValue, section: 0), animated: true, scrollPosition: [])
        }
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    var selectedSegmentTintColor: UIColor = .e64919
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(YLSegmentedTitleCell.self, forCellWithReuseIdentifier: YLSegmentedTitleCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(frame: CGRect, items: [String]) {
        self.items = items
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        if let count = items?.count, count > 0 {
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        }
    }
}

extension YLSegmentedControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YLSegmentedTitleCell.reuseIdentifier, for: indexPath) as! YLSegmentedTitleCell
        cell.selectedSegmentTintColor = selectedSegmentTintColor
        cell.titleLabel.text = items?[indexPath.item]
        return cell
    }    
}

extension YLSegmentedControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != selectedSegmentIndex {
            selectedSegmentIndex = indexPath.item
        }
    }
}

extension YLSegmentedControl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let title = items?[indexPath.item] else {
            return .zero
        }
        let size = title.size(font: .systemFont(ofSize: 18, weight: .medium))
        return CGSize(width: size.width, height: frame.height)
    }
}
