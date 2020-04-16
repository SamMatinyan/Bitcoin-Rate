//
//  ViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/25/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var xrpLabel: UILabel!
    
    private var bitcoinManager = BitcoinManager()
    private let activityView = UIActivityIndicatorView(style: .medium)
    private var curr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatory()

        bitcoinManager.delegate = self
        bitcoinManager.fetchPrice(currency: "GBP")
        curr = "￡"
    }
    
    @IBAction func currencyDidChange(_ sender: UISegmentedControl) {
        showActivityIndicatory()
        switch sender.selectedSegmentIndex {
        case 0:
            bitcoinManager.fetchPrice(currency: "GBP")
            curr = "￡"
        case 1:
            bitcoinManager.fetchPrice(currency: "EUR")
            curr = "€"
        case 2:
            bitcoinManager.fetchPrice(currency: "USD")
            curr = "＄"
        case 3:
            bitcoinManager.fetchPrice(currency: "RUB")
            curr = "₽"
        default:
            print("?")
        }
    }
}
extension ViewController: BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: BitcoinManager, bitcoin: [BitcoinData]) {
          DispatchQueue.main.async {
            self.btcLabel.text = bitcoin[0].shortPrice + self.curr
            self.ethLabel.text = bitcoin[1].shortPrice + self.curr
            self.xrpLabel.text = bitcoin[2].shortPrice + self.curr
            self.activityView.stopAnimating()
              }
          }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
     func showActivityIndicatory() {
        activityView.color = .darkGray
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
}
    



