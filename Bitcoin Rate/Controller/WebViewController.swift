//
//  WebViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 6/15/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://cryptonews.com/")!
        let request = URLRequest(url: myURL)
        webView.load(request)
    }

}
