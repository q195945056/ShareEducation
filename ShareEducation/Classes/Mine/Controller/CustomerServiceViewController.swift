//
//  CustomerServiceViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/5.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class CustomerServiceViewController: UIViewController {
    
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var contactView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    lazy var qustions: [Question] = {
        var array = [Question]()
        var answer1 = Question(question: "问题1", answer: "答案1")
        var answer2 = Question(question: "问题2", answer: "答案2")
        var answer3 = Question(question: "问题3", answer: "答案3")

        array.append(answer1)
        array.append(answer2)
        array.append(answer3)
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupUI() {
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        contactView.layer.cornerRadius = 10
        contactView.layer.shadowColor = UIColor.black.cgColor
        contactView.layer.shadowRadius = 10
        contactView.layer.shadowOpacity = 0.05
        
        navigationItem.title = "我的客服"
        tableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: QuestionCell.reuseIdentifier)
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

extension CustomerServiceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qustions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.reuseIdentifier, for: indexPath) as! QuestionCell
        let answer = qustions[indexPath.row]
        cell.question = answer
        let isLastLine = indexPath.row == qustions.count - 1
        cell.lineView.isHidden = isLastLine
        return cell
    }
    
    
}

extension CustomerServiceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = qustions[indexPath.row]
        answer.expand = !answer.expand
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
