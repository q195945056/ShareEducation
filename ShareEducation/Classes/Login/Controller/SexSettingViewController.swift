//
//  SexSettingViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/9.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit
import Jelly

class SexSettingViewController: UIViewController {
    
    static var animator: Animator?
    
    static func show(in viewController: UIViewController, sex: String? = "男", selectionHandler: ((Int) -> Void)? = nil) {
        let controller = SexSettingViewController()
        controller.originalValue = sex
        controller.didSelectSex = selectionHandler
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 260))
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 0, backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = CoverPresentation(directionShow: .bottom, directionDismiss: .bottom, uiConfiguration: uiConfiguration, size: size, alignment: PresentationAlignment(vertical: .bottom, horizontal: .center))
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        viewController.present(controller, animated: true)
    }
    
    @IBOutlet var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let originalValue = originalValue {
            let index: Int
            if originalValue == "男" {
                index = 0
            } else {
                index = 1
            }
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
    }
    
    var didSelectSex: ((Int) -> Void)?

    var originalValue: String?
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onConfirmButtonPressed(_ sender: Any) {
        let index = pickerView.selectedRow(inComponent: 0)
        didSelectSex?(index)
        dismiss(animated: true)
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

extension SexSettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
}

extension SexSettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "男"
        } else {
            return "女"
        }
    }
}
