//
//  CryptoCurData.swift
//  Bitcoin Rate
//
//  Created by Apple on 09.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import Foundation

struct CryptoCurData {
    private var cryptoPickerComponent  = ["BTC" : "Bitcoin",
                                          "ETH" : "Etherium",
                                          "XRP" : "Ripple"]
    
    private var currencyPickerComponent = ["USD🇺🇸" : "$",
                                           "GBP🇬🇧" : "£",
                                           "RUB🇷🇺" : "₽",
                                           "AMD🇦🇲" : "֏"]
    
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
}
