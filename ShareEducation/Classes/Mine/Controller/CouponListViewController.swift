//
//  CouponListViewController.swift
//  
//
//  Created by 严明俊 on 2019/12/5.
//

import UIKit

class CouponListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

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
        navigationItem.title = "优惠券"
        tableView.register(UINib(nibName: "CouponCell", bundle: nil), forCellReuseIdentifier: CouponCell.reuseIdentifier)
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

extension CouponListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCell.reuseIdentifier, for: indexPath) as! CouponCell
        return cell
    }
    
    
}

extension CouponListViewController: UITableViewDelegate {
    
}
