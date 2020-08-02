//
//  MessageListViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/5.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {
    
    var messages = [Message]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupUI() {
        navigationItem.title = "消息中心"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: MessageCell.reuseIdentifier)
    }
    
    func requestData() {
        serviceProvider.request(.sysMyMsgList) { result in
            switch result {
            case let .success(response):

                guard let responseData = try? response.mapObject(ListResult<Message>.self) else {
                    return
                }
                
                guard let data = responseData.data else {
                    return
                }
                
                self.messages = data
                self.tableView.reloadData()
                
                
                break
            case let .failure(error):
                break
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

extension MessageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.titleLabel.text = message.title
        cell.contentLabel.text = message.msgContent
        cell.timeLabel.text = message.createTime.toString(.date(DateFormatter.Style.medium))
        return cell
    }
    
    
}

extension MessageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]

        let urlString = message.url
        let controller = WebViewController(url: urlString!)
        navigationController?.pushViewController(controller, animated: true)
    }
}
