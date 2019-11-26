//
//  GradeSettingViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/10/23.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SnapKit

class GradeSettingViewController: UIViewController {
    
    let titleLabel: UILabel = UILabel.init().then { (label) in
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .darkTextColor
        label.text = "设置当前所在年级"
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 15)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 19, bottom: 25, right: 19)
        let horizontalSpacing = 15.0
        let verticalSpacing = 12.0
        let width = ((UIScreen.width - 108) - 2 * horizontalSpacing) / 3
        let height = 28.0
        layout.itemSize = CGSize(width: width, height: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GradeCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GradeCollectionHeader.reuseIdentifier)
        collectionView.register(GradeCollectionCell.self, forCellWithReuseIdentifier: GradeCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    var didSelectGrade: ((Grade) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Private
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(30)
            make.centerX.equalTo(view)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view)
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

extension GradeSettingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ShareData.shared.gradetypes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let gradeType = ShareData.shared.gradetypes?[section]
        return gradeType?.grades.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GradeCollectionCell.reuseIdentifier, for: indexPath) as! GradeCollectionCell
        let gradeType = ShareData.shared.gradetypes?[indexPath.section]
        let grade = gradeType?.grades[indexPath.row]
        cell.titleLabel.text = grade?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GradeCollectionHeader.reuseIdentifier, for: indexPath) as! GradeCollectionHeader
        let gradeType = ShareData.shared.gradetypes?[indexPath.section]
        headerView.titleLabel.text = gradeType?.name
        return headerView
    }
}

extension GradeSettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gradeType = ShareData.shared.gradetypes?[indexPath.section]
        let grade = gradeType?.grades[indexPath.row]
        if let didSelectGrade = didSelectGrade {
            didSelectGrade(grade!)
        }
        ShareSetting.shared.grade = grade!
        
        dismiss(animated: true)
    }
}

extension GradeSettingViewController: UICollectionViewDelegateFlowLayout {
    
}
