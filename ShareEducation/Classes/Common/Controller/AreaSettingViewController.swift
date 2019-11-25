//
//  AreaSettingViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/11/24.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class AreaSettingViewController: UIViewController {
    
    lazy var provinceList: [[String: String]]? = {
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
    
    lazy var cityMap: [String: [[String: String]]]? = {
        let cityPath = Bundle.main.path(forResource: "city", ofType: "plist")
        let plistData = FileManager.default.contents(atPath: cityPath!)!
        do {
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
            let cityMap = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String: [[String: String]]]
            return cityMap
        } catch  {
            return nil
        }
    }()
    
    var cityList: [[String: String]]?
    
    @IBOutlet var pickerView: UIPickerView!
    
    var didSelectArea: ((Area) -> Void)?

    var showAllArea = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerView(pickerView, didSelectRow: 0, inComponent: 0)
    }
    
    // MARK: - Actions
    
    @IBAction func onDoneButtonPressed(sender: Any) {
        let index = pickerView.selectedRow(inComponent: 1)
        let cityDic = cityList?[index]
        let cityName = cityDic?["name"]
        
        let area = Area(id: 0, name: cityName!)
        self.didSelectArea?(area)
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
            return provinceList?.count ?? 0
        } else {
            return cityList?.count ?? 0
        }
    }
}

extension AreaSettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let provinceDic = provinceList?[row]
            let provinceName = provinceDic?["name"]
            return provinceName
        } else {
            let cityDic = cityList?[row]
            let cityName = cityDic?["name"]
            return cityName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            guard let provinceList = provinceList, let cityMap = cityMap else {
                return
            }
            let provinceDic = provinceList[row]
            let provinceCode = provinceDic["id"]
            let array = cityMap[provinceCode!]
            
            cityList = array
            pickerView.reloadComponent(1)
        }
    }
}
