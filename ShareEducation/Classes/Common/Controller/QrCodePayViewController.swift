//
//  QrCodePayViewController.swift
//  ShareEducation
//
//  Created by yanmingjun on 2020/8/16.
//  Copyright © 2020 严明俊. All rights reserved.
//

import UIKit
import EFQRCode
import Jelly
import SwiftyJSON

class QrCodePayViewController: UIViewController {
    
    static var animator: Animator?
    
    static func show(in viewController: UIViewController, price: Int, urlString: String, orderID: String, completion: (() -> Void)? = nil) {
        let controller = QrCodePayViewController()
        controller.price = price
        controller.qrcodeString = urlString
        controller.orderID = orderID
        controller.successHandler = completion
        let size = PresentationSize(width: .custom(value: 313), height: .custom(value: 413))
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 9, backgroundStyle: .dimmed(alpha: 0.6))
        let presentation = FadePresentation(size: size, ui: uiConfiguration)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: controller)
        self.animator = animator
        viewController.present(controller, animated: true)
    }
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var qrCodeImageView: UIImageView!
    
    var successHandler: (() -> Void)?
    
    var price: Int = 0
    
    var qrcodeString: String = ""
    
    var orderID: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        priceLabel.text = String(format: "￥%.2f", Float(price) / 100)
        if let tryImage = EFQRCode.generate(content: qrcodeString) {
            let image = UIImage(cgImage: tryImage)
            qrCodeImageView.image = image
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startTimer()
    }
    
    var timer: Timer?
    
    var secondLeft = 60
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimerTick(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    @objc func onTimerTick(_ timer: Timer) {
        checkPayStatus()
    }
    
    func checkPayStatus() {
        serviceProvider.request(.courseSearchOrder(orderID: orderID)) { (result) in
            switch result {
            case let .success(response):
                guard let responseData = try? JSON(data: response.data) else {
                    return
                }
                
                let result = responseData["result"].intValue
                guard result == 1 else {
                    return
                }
                self.stopTimer()
                
                self.dismiss(animated: true, completion: self.successHandler)
            case .failure:
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
