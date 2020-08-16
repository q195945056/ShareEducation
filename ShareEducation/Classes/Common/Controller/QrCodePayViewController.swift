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

class QrCodePayViewController: UIViewController {
    
    static var animator: Animator?
    
    static func show(in viewController: UIViewController, price: Int, urlString: String) {
        let controller = QrCodePayViewController()
        controller.price = price
        controller.qrcodeString = urlString
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
    
    var price: Int = 0
    
    var qrcodeString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        priceLabel.text = String(format: "￥%.2f", Float(price) / 100)
        if let tryImage = EFQRCode.generate(content: qrcodeString) {
            let image = UIImage(cgImage: tryImage)
            qrCodeImageView.image = image
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
