//
//  ViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/25/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var bitcoinManager = BitcoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bitcoinManager.delegate = self
       // bitcoinManager.fetchPrice(currency: "GBP")
    }
    
    @IBAction func currencyDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bitcoinManager.fetchPrice(currency: "GBP")
        case 1:
            bitcoinManager.fetchPrice(currency: "EUR")
        case 2:
            bitcoinManager.fetchPrice(currency: "USD")
        case 3:
            bitcoinManager.fetchPrice(currency: "RUB")
        default:
            print("?")
        }
    }
}
extension ViewController: BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: BitcoinManager, bitcoin: [BitcoinData]) {
          DispatchQueue.main.async {
            self.priceLabel.text = bitcoin[0].shortPrice
              }
          }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
    



