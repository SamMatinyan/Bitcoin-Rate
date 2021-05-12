//
//  CryptoCurData.swift
//  Bitcoin Rate
//
//  Created by Apple on 09.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import Foundation

struct StoredData {
    
    private let baseURL  = "https://api.nomics.com/v1/currencies/ticker?key=eaa9144b8f293102f8d5548b0d4298fd&ids="
    private var crypto   = "BTC"
    private var currency = "AMD"
    private var symbol   = "֏"
    private var short    = false
    
    private var cryptoPickerComponent  = ["BTC" : "Bitcoin",
                                          "ETH" : "Etherium",
                                          "XRP" : "Ripple"]
    
    private var currencyPickerComponent = ["USD🇺🇸" : "$",
                                           "GBP🇬🇧" : "£",
                                           "RUB🇷🇺" : "₽",
                                           "AMD🇦🇲" : "֏"]
    
    //MARK: - Getters & Setters
    
    func getBaseURL() -> String {
        return baseURL
    }
    
    func getCrypto() -> String {
        return crypto
    }
    
    func getCurrency() -> String {
        return currency
    }
    
    func getSymbol() -> String {
        return symbol
    }
    
    func isShort() -> Bool {
        return short
    }
    
    func getFullURLToFetch() -> String {
        return "\(baseURL)" + "\(crypto)" + "&convert=" + "\(currency)"
    }
    
    func getSortedCryptoPickerItems() -> [String] {
        return cryptoPickerComponent.keys.sorted()
    }
    
    func getSortedCurrencies() -> [String] {
        return currencyPickerComponent.keys.sorted()
    }
    
    func getCryptoPickerDictionary() -> [String : String] {
        return cryptoPickerComponent
    }
    
    func getCurrencyPickerDictionary() -> [String : String] {
        return currencyPickerComponent
    }
    
    mutating func setCrypto(newValue: String) {
        self.crypto = newValue
    }
    
    mutating func setCurrency(newValue: String) {
        self.currency = newValue
    }
    
    mutating func setSymbol(newValue: String) {
        self.symbol = newValue
    }
    
    mutating func setShort(newValue: Bool) {
        self.short = newValue
    }
}
