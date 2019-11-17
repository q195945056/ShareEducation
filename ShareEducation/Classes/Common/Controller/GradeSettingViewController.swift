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
        label.font = .systemFont(ofSize: 15)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        let horizontalSpacing = 15.0
        let verticalSpacing = 15.0
        let width = ((UIScreen.width - 100) - 2 * horizontalSpacing) / 3
        let height = 35.0
        layout.itemSize = CGSize(width: width, height: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GradeCollectionCell.reuseIdentifier, for: indexPath) as! GradeCollectionCell
        return cell
    }
    
    
}

extension GradeSettingViewController: UICollectionViewDelegate {
    
}

extension GradeSettingViewController: UICollectionViewDelegateFlowLayout {
    
}
