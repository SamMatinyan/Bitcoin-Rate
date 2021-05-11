//
//  ViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/25/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var cryptoLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private var networkingHelper = NetworkingHelper()
    private var cryptoCurData  = CryptoCurData()
    private let activityView   = UIActivityIndicatorView(style: .medium)
    private var short          = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        networkingHelper.delegate = self
        networkingHelper.fetchPrice()
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "segInfo", sender: self)
    }
    
    
    //MARK: - Size change
    @IBAction func sizeDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showActivityIndicator()
            short = true
            networkingHelper.fetchPrice()
        case 1:
            showActivityIndicator()
            short = false
            networkingHelper.fetchPrice()
        default:
            short = true
        }
    }
}

extension MainViewController: BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: NetworkingHelper, bitcoin: [BitcoinData]) {
        if short == true {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + bitcoinManager.getCrypto()
                self.valueLabel.text = bitcoin[0].getShortPrice()
                self.activityView.stopAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + bitcoinManager.getCrypto()
                self.valueLabel.text = bitcoin[0].getPrice() + self.cryptoCurData.getSymbol()
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

//MARK: - UIPickerViewDataSource & Delegate

extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cryptoCurData.getSortedCryptoPickerItems().count
        } else {
            return cryptoCurData.getSortedCurrencies().count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let whatNeedToBePresented = cryptoCurData.getSortedCryptoPickerItems()[row]
            return  whatNeedToBePresented + " (\(cryptoCurData.getCryptoPickerDictionary()[whatNeedToBePresented] ?? ""))"
        } else {
            return cryptoCurData.getSortedCurrencies()[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showActivityIndicator()
        let currentSelectedCurrency = cryptoCurData.getSortedCurrencies()[row]
        if component == 0 { //CRYPTO
            self.networkingHelper.setCrypto(newValue: cryptoCurData.getSortedCryptoPickerItems()[row])
        } else {            //CURRENCY
            self.networkingHelper.setCurreny(newValue: String(currentSelectedCurrency.dropLast()))//Drops Emoji(flag)
            self.cryptoCurData.setSymbol(newValue: cryptoCurData.getCurrencyPickerDictionary()[currentSelectedCurrency] ?? "")
        }
        self.networkingHelper.fetchPrice()
    }
}


