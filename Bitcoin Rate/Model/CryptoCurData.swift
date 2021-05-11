//
//  CryptoCurData.swift
//  Bitcoin Rate
//
//  Created by Apple on 09.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import Foundation

struct CryptoCurData {
    private var leftPickerComponent  = ["BTC", "ETH", "XRP"]
    private var rightPickerComponent = ["USD🇺🇸" : "$",
                                        "GBP🇬🇧" : "£",
                                        "RUB🇷🇺" : "₽",
                                        "AMD🇦🇲" : "֏"]
    
    func getLeftPickerComponentSorted() -> [String] {
        return leftPickerComponent.sorted()
    }
    
    func getRightPickerComponentSortedKeys() -> [String] {
        return rightPickerComponent.keys.sorted()
    }
    
    func getRightPickerComponent() -> [String : String] {
        return rightPickerComponent
    }
}
