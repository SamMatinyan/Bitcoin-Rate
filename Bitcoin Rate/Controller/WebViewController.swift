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
    
    //MARK: - Edit button pressed
    
    @IBAction func changeLangPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "cryptonews.com", style: .default, handler: { (action) in
            self.webLoadUrl(url: "https://cryptonews.com/")
        }))
        
        alertController.addAction(UIAlertAction(title: "bitnovosti.com", style: .default, handler: { (action) in
            self.webLoadUrl(url: "https://bitnovosti.com/")
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webLoadUrl(url: "https://cryptonews.com/")
    }

    func webLoadUrl(url: String) {
        let myURL = URL(string: url)!
        let request = URLRequest(url: myURL)
        webView.load(request)
    }
    
}
