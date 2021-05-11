//
//  BitcoinManager.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/27/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import Foundation

protocol BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: BitcoinManager, bitcoin: [BitcoinData])
    func didFailWithError(error: Error)
}

struct BitcoinManager {
    
    var delegate: BitcoinManagerDelegate?
    
    private let baseURL = "https://api.nomics.com/v1/currencies/ticker?key=eaa9144b8f293102f8d5548b0d4298fd&ids="
    
    private var crypto   = "BTC"
    private var currency = "AMD"
    private var symbol   = "֏"
    
    func fetchPrice() {
        let urlString = "\(baseURL)" + "\(crypto)" + "&convert=" + "\(currency)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let bitcoin = self.parseJSON(safeData) {
                        self.delegate?.didUpdate(self, bitcoin: bitcoin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ bitcoinData: Data) -> [BitcoinData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([BitcoinData].self, from: bitcoinData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

//MARK: - Getters & Setters

extension BitcoinManager {
    
    func getCrypto() -> String {
        return crypto
    }
    
    func getSymbol() -> String {
        return symbol
    }
    
    mutating func setCrypto(newValue: String) {
        self.crypto = newValue
    }
    
    mutating func setCurreny(newValue: String) {
        self.currency = newValue
    }
    
    mutating func setSymbol(newValue: String) {
        self.symbol = newValue
    }
}
