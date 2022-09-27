//
//  TransactionsRepository.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import Foundation

enum TransactionsAPIError: Error {
    case badURL
    case badSerialization
    case badResponse
    case other(error: Error)
}

final class TransactionsRepository {
    
    static func fetchTransactions(callback: @escaping (_ data: [Transaction]?, _ error: Error?) -> Void) {
        
        if let url = URL_FETCH_TRANSACTIONS {
            
            let session = URLSession.shared
            
             session.dataTask(with: url) { data, response, error in
                 guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                     if let error = error {
                         callback(nil, TransactionsAPIError.other(error: error))
                     }
                     return
                 }
                 
                 if response.statusCode == 200 {
                     let decoder = JSONDecoder()
                     do {
                         let transactions = try decoder.decode([Transaction].self, from: data)
                         
                         /* Prueba */
                         let transactionsDictionary = Dictionary(grouping: transactions, by: { $0.sku })
                         print(transactionsDictionary)
                         /* Fin de prueba */
                         
                         callback(transactions, nil)
                     } catch {
                         callback(nil, TransactionsAPIError.badSerialization)
                     }
                 }
                 
                 switch response.statusCode {
                 case 200:
                     let decoder = JSONDecoder()
                     do {
                         let transactions = try decoder.decode([Transaction].self, from: data)
                         callback(transactions, nil)
                     } catch {
                         callback(nil, TransactionsAPIError.badSerialization)
                     }
                 default:
                     callback(nil, TransactionsAPIError.badResponse)
                 }
             }.resume()
            
        } else {
            
            callback(nil, TransactionsAPIError.badURL)
        }
    }
}