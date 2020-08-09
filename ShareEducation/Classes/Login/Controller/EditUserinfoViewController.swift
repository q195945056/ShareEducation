//
//  EditUserinfoViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/8.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import IQKeyboardManagerSwift

class EditUserinfoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var image: UIImage?
    
    var placeholderImage: UIImage? = UIImage(named: "head_student_man")
    
    var originData: JSON?
    
    var titles: [String] = ["头像", "用户昵称", "真实姓名", "性别", "学籍号", "地区", "所在学校", "年级", "联系邮箱", "手机号码"]
    
    
    var originalValues = [Int : String]()
    
    var values = [Int : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        requestData()
    }
    
    func requestData() {
        serviceProvider.request(.memberInfo) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    return
                }
                let result = responseData["result"].intValue
                guard result == 1 else {
                    return
                }
                self.update(responseData["data"])
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func update(_ data: JSON) {
        values[0] = data["pic"].stringValue
        values[1] = data["nickname"].stringValue
        values[2] = data["truename"].stringValue
        let sex = data["sex"].intValue
        if sex == 0 {
            values[3] = "男"
        } else {
            values[3] = "女"
        }
        values[4] = data["schoolnum"].stringValue
        let area = ShareData.shared.findArea(by: data["areaid"].intValue)
        if area == .default {
            values[5] = data["area"].stringValue
        } else {
            values[5] = area.name
        }
        values[6] = data["schoolname"].stringValue
        
        let grade = ShareData.shared.findGrade(by: data["gradeid"].intValue)
        if grade == .default {
            values[7] = data["grade"].stringValue
        } else {
            values[7] = grade.name
        }
        values[8] = data["emaill"].stringValue
        values[9] = data["phone"].stringValue
        
        originalValues = values
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupUI() {
        navigationItem.title = "个人资料"
        tableView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: UserInfoCell.reuseIdentifier)
    }
    
    @objc func onEditChange(_ textFiled: UITextField) {
        var cell: UITableViewCell?
        var superView = textFiled.superview
        while superView != nil {
            if let view = superView as? UITableViewCell {
                cell = view
                break
            }
            superView = superView?.superview
        }
        
        if let cell = cell, let indexPath = tableView.indexPath(for: cell) {
            values[indexPath.row] = textFiled.text
        }
        
        checkEdingState()
    }
    
    func checkEdingState() {
        for (key, value) in values {
            let originalValue = originalValues[key]
            if originalValue != value {
                isEditing = true
                break
            }
        }
    }
    
    override var isEditing: Bool {
        set {
            super.isEditing = newValue
            
            if newValue {
                let doneItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.onDoneButtonPressed(_:)))
                navigationItem.rightBarButtonItem = doneItem
                
                let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(self.onCancelButtonPressed(_:)))
                navigationItem.leftBarButtonItem = cancelItem
            } else {
                navigationItem.leftBarButtonItem = nil
                navigationItem.rightBarButtonItem = nil
            }
        }
        get {
            super.isEditing
        }
    }
    
    @objc func onDoneButtonPressed(_ sender: Any) {
        var nickName: String?
        var trueName: String?
        var sex: Int?
        var schoolNum: String?
        var areaID: Int?
        var areaString: String?
        var schoolName: String?
        var gradeID: Int?
        var email: String?
        var phone: String?
        
        for (key, value) in values {
            switch key {
            case 0:
                break
            case 1:
                nickName = value
            case 2:
                trueName = value
            case 3:
                sex = value == "男" ? 0:1
            case 4:
                schoolNum = value
            case 5:
                let area = ShareData.shared.findArea(by: value)
                if area == .default {
                    areaID = area.id
                    areaString = value
                } else {
                    areaID = area.id
                }
            case 6:
                schoolName = value
            case 7:
                let grade = ShareData.shared.findGrade(by: value)
                gradeID = grade.id
            case 8:
                email = value
            case 9:
                phone = value
            default:
                break
            }
        }
        
        view.endEditing(true)
        
        User.modifyUserInfo(image: image, nickName: nickName ?? "", trueName: trueName ?? "", sex: sex ?? 0, schoolNum: schoolNum ?? "", areaID: areaID ?? 0, schoolName: schoolName ?? "", gradeID: gradeID ?? 0, email: email ?? "", phone: phone ?? "") { (result) in
            switch result {
            case let .success(imageURLString):
                if let imageURLString = imageURLString {
                    self.values[0] = imageURLString.fullURLString
                    self.image = nil
                }
                self.isEditing = false
                self.originalValues = self.values
                Utilities.toast("修改成功")

            case let .failure(error):
                Utilities.toast(error.errorDescription)
            }
        }
    }
    
    @objc func onCancelButtonPressed(_ sender: Any) {
        isEditing = false
        values = originalValues
        image = nil
        tableView.reloadData()
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

extension EditUserinfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentifier, for: indexPath) as! UserInfoCell
        
        let title = titles[indexPath.row]
        cell.titleLabel.text = title
        
        let value = values[indexPath.row]
        if indexPath.row == 0 {
            cell.headImageView.isHidden = false
            cell.textField.isHidden = true
            if let image = self.image {
                cell.headImageView.image = image
            } else {
                cell.headImageView.kf.setImage(with: URL(string: value?.fullURLString ?? ""), placeholder: placeholderImage)
            }
        } else {
            cell.headImageView.isHidden = true
            cell.textField.isHidden = false
            cell.textField.text = value
            
            if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 8 {
                cell.textField.isUserInteractionEnabled = true
                cell.textField.addTarget(self, action: #selector(self.onEditChange(_:)), for: .editingChanged)
            } else {
                cell.textField.isUserInteractionEnabled = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        } else {
            return 50
        }
    }
    
}

extension EditUserinfoViewController: UITableViewDelegate {
    func showImageMenu() {
        let alertController = UIAlertController(title: "选择照片", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            self.showImagePicker(.camera)
        }
        let albumAction = UIAlertAction(title: "手机相册", style: .default) { (action) in
            self.showImagePicker(.photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {//修改头像
            showImageMenu()
        } else if indexPath.row == 3 {//修改性别
            let sex = values[indexPath.row]
            SexSettingViewController.show(in: self, sex: sex) { (index) in
                
                if index == 0 {
                    self.values[indexPath.row] = "男"
                } else {
                    self.values[indexPath.row] = "女"
                }
                self.checkEdingState()
                self.tableView.reloadData()
            }
        } else if indexPath.row == 5 {//修改地区
            AreaSettingViewController.show(in: self, isRegister: true) { (area) in
                self.values[indexPath.row] = area.name
                self.checkEdingState()
                self.tableView.reloadData()
            }
        } else if indexPath.row == 7 {//修改年级
            GradeSettingViewController.show(in: self) { (grade) in
                self.values[indexPath.row] = grade.name
                self.checkEdingState()
                self.tableView.reloadData()
            }
        }
    }

}

extension EditUserinfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.editedImage] as? UIImage
        placeholderImage = image
        isEditing = true
        tableView.reloadData()
        
        picker.dismiss(animated: true) {
             
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
