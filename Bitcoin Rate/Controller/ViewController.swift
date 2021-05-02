//
//  ViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/25/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    private var bitcoinManager = BitcoinManager()
    private let activityView   = UIActivityIndicatorView(style: .medium)
    private var shortCurrName  = ""
    private var currency       = ""
    private var short          = true
    private var cryptoPickerData = ["BTC",
         "ETH",
         "XRP",
         "🇦🇲"
        ]
    private var currencyPickerData = ["USD",
                                      "GBP",
                                      "RUB",
                                      "AMD🇦🇲"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        bitcoinManager.delegate = self
        bitcoinManager.fetchPrice(currency: "GBP")
        shortCurrName = "￡"
        currency = "GBP"
    }
    
    //MARK: - Info button pressed
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "segInfo", sender: self)
    }
    
    
    //MARK: - Size change
    
    @IBAction func sizeDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showActivityIndicator()
            short = true
            bitcoinManager.fetchPrice(currency: currency)
        case 1:
            showActivityIndicator()
            short = false
            bitcoinManager.fetchPrice(currency: currency)
        default:
            short = true
        }
    }
    
    //MARK: - Currency change
    
    @IBAction func currencyDidChange(_ sender: UISegmentedControl) {
        showActivityIndicator()
        switch sender.selectedSegmentIndex {
        case 0:
            currency = "GBP"
            bitcoinManager.fetchPrice(currency: currency)
            shortCurrName = "￡"
        case 1:
            currency = "EUR"
            bitcoinManager.fetchPrice(currency: currency)
            shortCurrName = "€"
        case 2:
            currency = "USD"
            bitcoinManager.fetchPrice(currency: currency)
            shortCurrName = "＄"
        case 3:
            currency = "RUB"
            bitcoinManager.fetchPrice(currency: currency)
            shortCurrName = "₽"
        default:
            print("?")
        }
    }
}
extension ViewController: BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: BitcoinManager, bitcoin: [BitcoinData]) {
        if short == true {
            DispatchQueue.main.async {
                //self.btcLabel.text = bitcoin[0].shortPrice + self.shortCurrName
                //self.ethLabel.text = bitcoin[1].shortPrice + self.shortCurrName
                //self.xrpLabel.text = bitcoin[2].shortPrice + self.shortCurrName
                self.activityView.stopAnimating()
            }
        } else {
            DispatchQueue.main.async {
                //self.btcLabel.text = bitcoin[0].price + self.shortCurrName
                //self.ethLabel.text = bitcoin[1].price + self.shortCurrName
                //self.xrpLabel.text = bitcoin[2].price + self.shortCurrName
                self.activityView.stopAnimating()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func showActivityIndicator() {
        activityView.color = .darkGray
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cryptoPickerData.count
        } else {
            return currencyPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cryptoPickerData[row]
        } else {
            return currencyPickerData[row]
        }
    }
}


