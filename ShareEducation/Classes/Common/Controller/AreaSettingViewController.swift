//
//  AreaSettingViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/24.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import Jelly

class AreaSettingViewController: UIViewController {
    
    static var animator: Animator?
    
    static func show(in viewController: UIViewController, isRegister: Bool = false, selectionHandler: ((Area) -> Void)? = nil) {
        let controller = AreaSettingViewController()
        controller.isRegister = isRegister
        controller.didSelectArea = selectionHandler
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 260))
        let aligment = PresentationAlignment(vertical: .bottom, horizontal: .center)
        let uiConfiguration = PresentationUIConfiguration( backgroundStyle: .dimmed(alpha: 0.8))
        let presentation = CoverPresentation(directionShow: .bottom, directionDismiss: .bottom, uiConfiguration: uiConfiguration, size: size, alignment: aligment, marginGuards: .zero)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        viewController.present(controller, animated: true)
    }
    
    

    
    var isRegister = false
    
    lazy var provinceList: [[String: String]]! = {
        let provincePath = Bundle.main.path(forResource: "province", ofType: "plist")
        let plistData = FileManager.default.contents(atPath: provincePath!)!
        do {
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
            let provinceArray = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [[String: String]]
            return provinceArray
        } catch  {
            return nil
        }
    }()
    
    lazy var cityMap: [String: [[String: String]]]! = {
        let cityPath = Bundle.main.path(forResource: "city", ofType: "plist")
        let plistData = FileManager.default.contents(atPath: cityPath!)!
        do {
            var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
            let cityMap = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String: [[String: String]]]
            return cityMap
        } catch  {
            return nil
        }
    }()
    
    var cityList: [[String: String]]?
    
    var provinces: [String] = [String]()
    
    var cities: [String] = [String]()
    
    @IBOutlet var pickerView: UIPickerView!
    
    var didSelectArea: ((Area) -> Void)?

    var showAllArea = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initData()
        
    }
    
    func initData() {
        if isRegister {
            provinces = provinceList!.map{ $0["name"]! }
            let provinceDic = provinceList.first
            let provinceCode = provinceDic!["id"]
            cities = (cityMap[provinceCode!])!.map{ $0["name"]! }
            pickerView(pickerView, didSelectRow: 0, inComponent: 0)
        } else {
            provinces = (ShareData.shared.areas?.keys.sorted())!
            
            
            let area = ShareSetting.shared.area
            var provinceIndex = 0
            var cityIndex = 0
            for i in 0..<provinces.count {
                let province = provinces[i]
                let cities = ShareData.shared.areas![province]!
                for j in 0..<cities.count {
                    let city = cities[j]
                    if area == city {
                        provinceIndex = i
                        cityIndex = j
                        break
                    }
                }
            }
            
            let key = provinces[provinceIndex]
            cities = ((ShareData.shared.areas?[key])?.map{ $0.name })!
            
            pickerView.reloadAllComponents()
            
            pickerView.selectRow(provinceIndex, inComponent: 0, animated: false)
            pickerView.selectRow(cityIndex, inComponent: 1, animated: false)
            
            
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onDoneButtonPressed(sender: Any) {
        let index = pickerView.selectedRow(inComponent: 1)
        let cityName = cities[index]
    
        var area = ShareData.shared.findArea(by: cityName)
        area.name = cityName
        if isRegister {
            self.didSelectArea?(area)
        } else {
            ShareSetting.shared.area = area
        }
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

extension AreaSettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinces.count
        } else {
            return cities.count
        }
    }
}

extension AreaSettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return provinces[row]
        } else {
            return cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            guard let provinceList = provinceList, let cityMap = cityMap else {
                return
            }
            
            if isRegister {
                let provinceDic = provinceList[row]
                let provinceCode = provinceDic["id"]
                let array = cityMap[provinceCode!]
                
                cities = (array?.map{ $0["name"]! })!
            } else {
                let key = provinces[row]
                cities = ((ShareData.shared.areas?[key])?.map{ $0.name })!
            }
            pickerView.reloadComponent(1)
        }
    }
}
