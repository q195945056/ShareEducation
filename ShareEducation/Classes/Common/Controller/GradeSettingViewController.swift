//
//  GradeSettingViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/10/23.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import SnapKit
import Jelly

class GradeSettingViewController: UIViewController {
    
    static var animator: Animator?
    
    static func show(in viewController: UIViewController, selectionHandler: ((Grade) -> Void)? = nil) {
        let controller = GradeSettingViewController()
        controller.didSelectGrade = selectionHandler
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 370))
        let marginGuards = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 15, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        viewController.present(controller, animated: true)
    }    
    
    var isRegister = false
    
    let titleLabel: UILabel = UILabel.init().then { (label) in
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .darkTextColor
        label.text = "设置当前所在年级"
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 15)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 19, bottom: 25, right: 19)
        let horizontalSpacing: CGFloat = 15.0
        let verticalSpacing = 12.0
        let width = ((UIScreen.width - 108) - 2 * horizontalSpacing) / 3
        let height: CGFloat = 28.0
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
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        if !isRegister {
            
            var indexPath: IndexPath?
            
            if ShareSetting.shared.grade == .default {
                indexPath = IndexPath(item: 0, section: 0)
            } else if let gradetypes = ShareData.shared.gradetypes {
                for (section, gradeType) in gradetypes.enumerated() {
                    for (item, grade) in gradeType.grades.enumerated() {
                        if grade == ShareSetting.shared.grade {
                            indexPath = IndexPath(item: item, section: section + 1)
                        }
                    }
                }
            }
            
            if let indexPath = indexPath {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
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
        return (ShareData.shared.gradetypes?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let gradeType = ShareData.shared.gradetypes?[section - 1]
            return gradeType?.grades.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GradeCollectionCell.reuseIdentifier, for: indexPath) as! GradeCollectionCell
        if indexPath.section == 0 {
            cell.titleLabel.text = "全部"
        } else {
            let gradeType = ShareData.shared.gradetypes?[indexPath.section - 1]
            let grade = gradeType?.grades[indexPath.row]
            cell.titleLabel.text = grade?.name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GradeCollectionHeader.reuseIdentifier, for: indexPath) as! GradeCollectionHeader
        if indexPath.section == 0 {
            headerView.titleLabel.text = ""
        } else {
            let gradeType = ShareData.shared.gradetypes?[indexPath.section - 1]
            headerView.titleLabel.text = gradeType?.name
        }
        return headerView
    }
}

extension GradeSettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let grade: Grade
        if indexPath.section == 0 {
            grade = Grade.default
        } else {
            let gradeType = ShareData.shared.gradetypes?[indexPath.section - 1]
            grade = gradeType!.grades[indexPath.row]
        }
        
        
        if let didSelectGrade = didSelectGrade {
            didSelectGrade(grade)
        }
        ShareSetting.shared.grade = grade
        
        dismiss(animated: true)
    }
}

extension GradeSettingViewController: UICollectionViewDelegateFlowLayout {
    
}
