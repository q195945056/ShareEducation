//
//  WebViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/11/26.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    var urlString: URLConvertible?
    
    init(url: URLConvertible) {
        urlString = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.urlString = nil
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "title")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            navigationItem.title = change?[NSKeyValueChangeKey.newKey] as? String
        }
    }
    
    func refresh() {
        var url: URL?
        do {
            url = try urlString?.asURL()
            if let url = url {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        } catch {
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

extension WebViewController: WKNavigationDelegate {
    
}

extension WebViewController: WKUIDelegate {
    
}
