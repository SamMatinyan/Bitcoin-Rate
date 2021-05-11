//
//  BitcoinManager.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/27/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import Foundation

protocol BitcoinManagerDelegate {
    func didUpdate(_ bitcoinManager: NetworkingHelper, bitcoin: [FetchedData])
    func didFailWithError(error: Error)
}

class NetworkingHelper {
    
    var delegate: BitcoinManagerDelegate?
    
    private let baseURL = "https://api.nomics.com/v1/currencies/ticker?key=eaa9144b8f293102f8d5548b0d4298fd&ids="
    
    private var crypto   = "BTC"
    private var currency = "AMD"
    
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
    
    func parseJSON(_ bitcoinData: Data) -> [FetchedData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([FetchedData].self, from: bitcoinData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

//MARK: - Getters & Setters

extension NetworkingHelper {
    
    func getCrypto() -> String {
        return crypto
    }
    
    func setCrypto(newValue: String) {
        self.crypto = newValue
    }
    
    func setCurreny(newValue: String) {
        self.currency = newValue
    }
}
