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
    
    private var bitcoinManager = BitcoinManager()
    private let cryptoCurData  = CryptoCurData()
    private let activityView   = UIActivityIndicatorView(style: .medium)
    private var short          = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        bitcoinManager.delegate = self
        bitcoinManager.fetchPrice()
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
            bitcoinManager.fetchPrice()
        case 1:
            showActivityIndicator()
            short = false
            bitcoinManager.fetchPrice()
        default:
            short = true
        }
    }
}

extension MainViewController: BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: BitcoinManager, bitcoin: [BitcoinData]) {
        if short == true {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + bitcoinManager.getCrypto()
                self.valueLabel.text = bitcoin[0].getShortPrice()
                self.activityView.stopAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.cryptoLabel.text = "1 " + bitcoinManager.getCrypto()
                self.valueLabel.text = bitcoin[0].getPrice()
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
            return cryptoCurData.getLeftPickerComponent().count
        } else {
            return cryptoCurData.getRightPickerComponent().count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cryptoCurData.getLeftPickerComponent()[row]
        } else {
            return cryptoCurData.getRightPickerComponent()[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showActivityIndicator()
        if component == 0 {
            self.bitcoinManager.setCrypto(newValue: cryptoCurData.getLeftPickerComponent()[row])
        } else {
            self.bitcoinManager.setCurreny(newValue: String(cryptoCurData.getRightPickerComponent()[row].dropLast()))
        }
        self.bitcoinManager.fetchPrice()
    }
}


