//
//  Bitcoin Model.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/27/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    let price: String
    
    var shortPrice: String {
        return String(price.dropLast(6))
    }
}


