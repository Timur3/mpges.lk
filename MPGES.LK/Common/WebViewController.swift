//
//  WebViewController.swift
//  mpges.lk
//
//  Created by Timur on 24.09.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate {
    var webView = WKWebView()
    var uuid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: MethodApi.baseUrlInitPro + uuid!)!))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ActivityIndicatorViewService.shared.showView(form: self.view)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicatorViewService.shared.hideView()
    }
    
    private func configure() {
        self.navigationItem.title = "Просмотр чека"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
