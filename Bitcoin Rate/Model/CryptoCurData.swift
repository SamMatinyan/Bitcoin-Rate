//
//  CryptoCurData.swift
//  Bitcoin Rate
//
//  Created by Apple on 09.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import Foundation

struct CryptoCurData {
    private var leftPickerComponent = ["BTC", "ETH", "XRP"]
    private var rightPickerComponent = ["USD🇺🇸", "GBP🇬🇧", "RUB🇷🇺", "AMD🇦🇲"]
    
    func getLeftPickerComponent() -> [String] {
        return leftPickerComponent
    }
    
    func getRightPickerComponent() -> [String] {
        return rightPickerComponent
    }
}
