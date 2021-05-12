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
    private var storedData       = StoredData()
    private let activityView     = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        networkingHelper.delegate = self
        networkingHelper.fetch(urlToFetch: storedData.getFullURLToFetch())
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "segInfo", sender: self)
    }
}

extension MainViewController: NetworkingHelperDelegate {
    func didUpdate(_ bitcoinManager: NetworkingHelper, bitcoin: [FetchedData]) {
        if storedData.isShort() {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + self.storedData.getCrypto()
                self.valueLabel.text = bitcoin[0].getShortPrice()
                self.activityView.stopAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + self.storedData.getCrypto()
                self.valueLabel.text = bitcoin[0].getPrice() + self.storedData.getSymbol()
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
            return storedData.getSortedCryptoPickerItems().count
        } else {
            return storedData.getSortedCurrencies().count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let whatNeedToBePresented = storedData.getSortedCryptoPickerItems()[row]
            return  whatNeedToBePresented + " (\(storedData.getCryptoPickerDictionary()[whatNeedToBePresented] ?? ""))"
        } else {
            return storedData.getSortedCurrencies()[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showActivityIndicator()
        let currentSelectedCurrency = storedData.getSortedCurrencies()[row]
        if component == 0 { //CRYPTO
            self.storedData.setCrypto(newValue: storedData.getSortedCryptoPickerItems()[row])
        } else {            //CURRENCY
            self.storedData.setCurrency(newValue: String(currentSelectedCurrency.dropLast()))//Drops Emoji(flag)
            self.storedData.setSymbol(newValue: storedData.getCurrencyPickerDictionary()[currentSelectedCurrency] ?? "")
        }
        self.networkingHelper.fetch(urlToFetch: storedData.getFullURLToFetch())
    }
}


