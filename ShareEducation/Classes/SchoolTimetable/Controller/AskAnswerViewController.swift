//
//  AskAnswerViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/25.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class AskAnswerViewController: UIViewController {
    
    var courseID: Int!
    
    var datas = [QaListItem]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }
    
    func loadData() {
        serviceProvider.request(.courseQaList(courseID: courseID)) { result in
            switch result {
            case let .success(response):
                guard let listResult = try? response.mapObject(ListResult<QaListItem>.self) else {
                    return
                }
                
                guard let data = listResult.data, !data.isEmpty else {
                    return
                }
                
                self.datas = data
                self.tableView.reloadData()
                
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }

    func setupUI() {
        tableView.register(R.nib.userMessasgeCell)
    }
    
    @IBAction func onSendButtonPressed(_ sender: Any) {
        serviceProvider.request(.courseQa(img: nil, cid: courseID, parentID: 0, content: textField.text ?? "")) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
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

extension AskAnswerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserMessasgeCell.reuseIdentifier, for: indexPath) as! UserMessasgeCell
        
        let data = datas[indexPath.row]
        let string = data.memberName + "：" + data.content
        cell.messageLabel.text = string
        return cell
    }
}

