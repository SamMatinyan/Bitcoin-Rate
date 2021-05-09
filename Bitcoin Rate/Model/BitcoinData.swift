//
//  Bitcoin Model.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/27/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    
    private let price: String
    
    private var shortPrice: String {
        return String(price.dropLast(7))
    }
    
    func getPrice() -> String {
        return price
    }
    
    func getShortPrice() -> String {
        return shortPrice
    }
}
