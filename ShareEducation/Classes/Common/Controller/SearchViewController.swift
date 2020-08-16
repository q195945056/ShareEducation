//
//  SearchViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/4.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly
import SwiftyJSON

class SearchViewController: UIViewController {
    
    var animator: Animator?
    
    @IBOutlet var titleView: UIView!
    
    @IBOutlet var titleWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var searchTextFiled: UITextField!
    
    lazy var cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancelButtonPressed(_:))).then {
        $0.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.normalTextColor], for: .normal)
        $0.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.normalTextColor], for: .highlighted)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var emptyView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    var results = [CourseItem]()
    
    var keywords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        requestHotwords()
    }
    
    func requestHotwords() {
        serviceProvider.request(.sysSearchTags) { (result) in
            switch result {
            case let .success(response):
                print(response)
                guard let responseData = try? JSON(data: response.data) else {
                    return
                }
                
                let result = responseData["result"].intValue
                guard result == 1 else {
                    return
                }
                
                var array = [String]()
                let jsonArray = responseData["data"].arrayValue
                for json in jsonArray {
                    array.append(json["name"].stringValue)
                }
                
                self.keywords = array
                self.collectionView.reloadData()
                
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }
    
    func setupUI() {
        titleWidthConstraint.constant = UIScreen.width - 110
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = cancelItem
        collectionView.register(UINib(nibName: "SearchHotCell", bundle: nil), forCellWithReuseIdentifier: SearchHotCell.reuseIdentifier)
        collectionView.register(UINib(nibName: "SearchHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.reuseIdentifier)
        tableView.register(HomeSetionTitleView.self, forHeaderFooterViewReuseIdentifier: HomeSetionTitleView.reuseIdentifier)
        tableView.register(HomeCourseCell.self, forCellReuseIdentifier: HomeCourseCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Actions
    
    @objc func onCancelButtonPressed(_ sender: Any) {
        searchTextFiled.text = nil
        searchTextFiled.resignFirstResponder()
        showHotWord()
    }
    
    @IBAction func onEditingDidChange(_ sender: UITextField) {
        if sender.text.isNilOrEmpty {
            showHotWord()
        }
    }

    @IBAction func onSearchButtonPressed(_ sender: Any) {
        let text = searchTextFiled.text
        guard !text.isNilOrEmpty else {
            return
        }
        
        search(for: text!)
    }
    
    // MARK: - Private
    
    func search(for text: String) {
        
        serviceProvider.request(.courseSearchList(keyword: text)) { (result) in
            switch result {
            case let .success(response):
                guard let listResult = try? response.mapObject(ListResult<CourseItem>.self) else {
                    self.showEmptyView()
                    return
                }
                
                guard let data = listResult.data, !data.isEmpty else {
                    self.showEmptyView()
                    return
                }
                self.results = data
                self.tableView.reloadData()
                self.showResult()
            case let .failure(error):
                self.showEmptyView()
                Utilities.toast(error.errorDescription ?? "网络请求错误")
            }
        }

    }
    
    func showEmptyView() {
        emptyView.isHidden = false
        collectionView.isHidden = true
        tableView.isHidden = true
    }
    
    func showHotWord() {
        emptyView.isHidden = true
        collectionView.isHidden = false
        tableView.isHidden = true
    }
    
    func showResult() {
        emptyView.isHidden = true
        collectionView.isHidden = true
        tableView.isHidden = false
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

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchHotCell.reuseIdentifier, for: indexPath) as! SearchHotCell
        cell.titleLabel.text = keywords[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.reuseIdentifier, for: indexPath) as! SearchHeaderView
        return headerView
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = keywords[indexPath.item]
        searchTextFiled.text = text
        searchTextFiled.resignFirstResponder()
        search(for: text)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = keywords[indexPath.item]

        var size = text.size(font: .systemFont(ofSize: 11, weight: .medium))
        size.width += 40
        size.height = 30
        return size
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCourseCell.reuseIdentifier, for: indexPath) as! HomeCourseCell
        
        let course = results[indexPath.row]
        cell.course = course
        cell.buyHandler = { course in
            let controller = CourseSbscribeAlertViewController()
            controller.course = course
            controller.confirmHandler = {
                let vc = SelectCourseViewController()
                vc.course = course
                mainNavigationController.pushViewController(vc, animated: true)
            }
            let size = PresentationSize(width: .fullscreen, height: .custom(value: 365))
            let marginGuards = UIEdgeInsets(top: 0, left: 47 + onePixelWidth, bottom: 0, right: 47 + onePixelWidth)
            let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.8))
            let presentation = FadePresentation(size: size, marginGuards: marginGuards, ui: uiConfiguration)
            let animator = Animator(presentation: presentation)
            animator.prepare(presentedViewController: controller)
            self.animator = animator
            mainNavigationController.present(controller, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return onePixelWidth
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSetionTitleView.reuseIdentifier) as! HomeSetionTitleView
//        headerView.titleLabel.textColor = .black
//        headerView.titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
//        headerView.indicatorImageView.isHidden = true
//        headerView.titleLabel.text = "明星老师"
//        return headerView
//    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = results[indexPath.row]
        let controller = CourseDetailViewController()
        controller.course = course
        mainNavigationController.pushViewController(controller, animated: true)
    }
}
