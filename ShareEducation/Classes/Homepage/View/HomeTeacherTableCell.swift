//
//  HomeTeacherListCell.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/10.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit

class HomeTeacherTableCell: UITableViewCell {
    //MARK: - Properties
    static let cellHeight: CGFloat = 215
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private Methods
    
    private func _commonInit() {
        
    }
    
}

extension HomeTeacherTableCell: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTeacherCollectionCell.reuseIdentifier, for: indexPath) as! HomeTeacherCollectionCell
        
        return cell
    }
}

extension HomeTeacherTableCell: UICollectionViewDelegate {
}

extension HomeTeacherTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 13, bottom: 15, right: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 159, height: 200)
    }
}

