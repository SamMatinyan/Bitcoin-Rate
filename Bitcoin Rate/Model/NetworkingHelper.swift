//
//  BitcoinManager.swift
//  Bitcoin Rate
//
//  Created by Apple on 3/27/20.
//  Copyright © 2020 ForZa. All rights reserved.
//

import Foundation

protocol NetworkingHelperDelegate {
    func didUpdate(_ bitcoinManager: NetworkingHelper, bitcoin: [FetchedData])
    func didFailWithError(error: Error)
}

class NetworkingHelper {
    
    var delegate: NetworkingHelperDelegate?
    
    func fetch(urlToFetch: String) {
        performRequest(with: urlToFetch)
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

