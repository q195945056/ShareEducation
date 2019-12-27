//
//  AskAnswerViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/25.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class AskAnswerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        tableView.register(R.nib.userMessasgeCell)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserMessasgeCell.reuseIdentifier, for: indexPath) as! UserMessasgeCell
        if indexPath.row == 0 {
            cell.messageLabel.text = "糯米不是米：起立"
        } else if indexPath.row == 1 {
            cell.messageLabel.text = "莫非：老师你的明信片写好没？"
        } else {
            cell.messageLabel.text = "[老师]王学军：课程开始了我们一起加油"
        }
        return cell
    }
}

