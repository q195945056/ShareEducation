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
    
    var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .e64919
        view.isHidden = true
        view.layer.cornerRadius = 1
        return view
    }()
    
    lazy var rightIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var rightIndicatorImage: UIImage? {
        didSet {
            if let rightIndicatorImage = rightIndicatorImage {
                rightIndicatorImageView.image = rightIndicatorImage
                contentView.addSubview(rightIndicatorImageView)
                rightIndicatorImageView.snp.makeConstraints { (make) in
                    make.leading.equalTo(titleLabel.snp.trailing).offset(5)
                    make.centerY.equalTo(titleLabel)
                }
            } else {
                rightIndicatorImageView.removeFromSuperview()
            }
        }
    }
    
    var aligment: YLSegmentedControl.VerticalAligment = .custom(bottomInset: 13) {
        didSet {
            switch aligment {
            case .center:
                titleLabel.snp.remakeConstraints { (make) in
                    make.center.equalTo(contentView)
                }
            case .bottom:
                titleLabel.snp.remakeConstraints { (make) in
                    make.centerX.bottom.equalTo(contentView)
                }
            case .custom(let bottomInset):
                titleLabel.snp.remakeConstraints { (make) in
                    make.centerX.equalTo(contentView)
                    make.bottom.equalTo(contentView).offset(-bottomInset)
                }
            }
        }
    }
    
    var showIndicator = false {
        didSet {
            if showIndicator && isSelected {
                indicatorView.isHidden = false
            } else {
                indicatorView.isHidden = true
            }
        }
    }
    
    var defaltSegmentTintColor: UIColor!
    
    var defaultSegmentFont: UIFont!
    
    var selectedSegmentFont: UIFont!
    
    var selectedSegmentTintColor: UIColor!
        
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if isSelected {
            titleLabel.font = selectedSegmentFont
            titleLabel.textColor = selectedSegmentTintColor
            indicatorView.isHidden = !showIndicator
        } else {
            titleLabel.font = defaultSegmentFont
            titleLabel.textColor = defaltSegmentTintColor
            indicatorView.isHidden = true
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
        
        contentView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(contentView)
            make.height.equalTo(2)
        }
    }
}

@IBDesignable class YLSegmentedControl: UIControl {
    
    var items: [String]? {
        didSet {
            reloadData()
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
    
    @IBInspectable var defaltSegmentTintColor: UIColor = .darkTextColor
    
    @IBInspectable var selectedSegmentTintColor: UIColor = .e64919
    
    @IBInspectable var defaultSegmentFont: UIFont = .systemFont(ofSize: 12, weight: .medium)
    
    @IBInspectable var selectedSegmentFont: UIFont = .systemFont(ofSize: 12, weight: .medium)
    
    var rightIndicatorImage: UIImage?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = contentInset
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(YLSegmentedTitleCell.self, forCellWithReuseIdentifier: YLSegmentedTitleCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    @IBInspectable var contentInset: UIEdgeInsets = .zero {
        didSet {
            reloadData()
        }
    }
    
    enum VerticalAligment {
        case center
        case bottom
        case custom(bottomInset: Double)
    }
    
    var aligment: VerticalAligment = .custom(bottomInset: 13)
    
    enum WidthOption {
        case flexible
        case custom(value: CGFloat)
    }
    
    var widthOption: WidthOption = .flexible {
        didSet {
            reloadData()
        }
    }
    
    @IBInspectable var showIndicator: Bool = false {
        didSet {
            reloadData()
        }
    }    
    
    init(frame: CGRect, items: [String]?) {
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
    
    private func reloadData() {
        let indexPath = collectionView.indexPathsForSelectedItems?.first
        collectionView.reloadData()
        if let indexPath = indexPath {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        } else if let count = items?.count, count > 0 {
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
        cell.showIndicator = showIndicator
        cell.defaltSegmentTintColor = defaltSegmentTintColor
        cell.selectedSegmentTintColor = selectedSegmentTintColor
        cell.defaultSegmentFont = defaultSegmentFont
        cell.selectedSegmentFont = selectedSegmentFont
        cell.titleLabel.text = items?[indexPath.item]
        cell.aligment = aligment
        cell.rightIndicatorImage = rightIndicatorImage
        cell.updateUI()
        return cell
    }
    
}

extension YLSegmentedControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != selectedSegmentIndex {
            selectedSegmentIndex = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return contentInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch widthOption {
        case .flexible:
            return 15
        case .custom(let value):
            if let count = items?.count, count > 1 {
                let spacing = (frame.width - contentInset.left - contentInset.right - value * CGFloat(count)) / CGFloat(count - 1)
                return spacing
            } else {
                return 0
            }
        }
    }
    
}

extension YLSegmentedControl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        switch widthOption {
        case .flexible:
            if let title = items?[indexPath.item] {
                let size = title.size(font: .systemFont(ofSize: 18, weight: .medium))
                width = size.width
            }
        case .custom(let value):
            width = value
        }
        
        return CGSize(width: width, height: frame.height)
    }
    
    
}
