//
//  FeedbackViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/12/7.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import SwiftyJSON

class FeedbackViewController: UIViewController {
    
    @IBOutlet var textView: RSKPlaceholderTextView!
    
    @IBOutlet var imageButton: UIButton!
    
    @IBOutlet var contactField: UITextField!
    
    @IBOutlet var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func onAddImageButtonPressed(_ sender: Any) {
        showImageMenu()
    }
    
    @IBAction func onConfirmButtonPressed(_ sender: Any) {
        guard let content = textView.text, !content.isEmpty else {
            Utilities.toast("请输入反馈内容")
            return
        }
        let image = imageButton.image(for: .normal)
        let contact = contactField.text
    
        Utilities.showLoading()
        
        serviceProvider.request(.sysOpinion(content: content, contacts: contact, img: image)) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    Utilities.showError("反馈失败")
                    return
                }
                let result = responseData["result"].intValue
                guard result == 1 else {
                    Utilities.showError("反馈失败")
                    return
                }
                Utilities.showSuccess("反馈成功")
                self.textView.text = nil
                self.imageButton.setImage(nil, for: .normal)
                self.contactField.text = nil
            case .failure:
                Utilities.showError("反馈失败")
            }
        }
    }
    
    
    // MARK: - Private
    
    func setupUI() {
        navigationItem.title = "意见反馈"
        var  tempView = textView.superview
        tempView!.layer.cornerRadius = 10
        tempView!.layer.borderColor = UIColor.e5e5e5.cgColor
        tempView!.layer.borderWidth = onePixelWidth
        
        tempView = contactField.superview
        tempView!.layer.cornerRadius = 5
        tempView!.layer.borderColor = UIColor.e5e5e5.cgColor
        tempView!.layer.borderWidth = onePixelWidth
        
        textView.placeholder = "请简要描述你的问题与意见，请不要超过200个字符。"
    }
    
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedbackViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        imageButton.setImage(image, for: .normal)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
