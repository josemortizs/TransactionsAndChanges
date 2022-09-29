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

final class TransactionsRepository: TransactionsRepositoryProtocol {
    
    static func fetchChanges(callback: @escaping (_ data: [Change]?, _ error: Error?) -> Void) {
        
        if let url = URL_FETCH_CHANGES {
            
            let session = URLSession.shared
            
             session.dataTask(with: url) { data, response, error in
                 guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                     if let error = error {
                         callback(nil, TransactionsAPIError.other(error: error))
                     }
                     return
                 }
                 
                 switch response.statusCode {
                 case 200:
                     let decoder = JSONDecoder()
                     do {
                         let changes = try decoder.decode([Change].self, from: data)
                         
                         /*
                          Solo incluyo esta sentencia para simular una carga algo más lenta de los recursos de red, para que puedan observarse correctamente los cambios de estado de las vistas
                          */
                         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                             callback(changes, nil)
                         }
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

                 switch response.statusCode {
                 case 200:
                     let decoder = JSONDecoder()
                     do {
                         let transactions = try decoder.decode([Transaction].self, from: data)
                         
                         /*
                          Solo incluyo esta sentencia para simular una carga algo más lenta de los recursos de red, para que puedan observarse correctamente los cambios de estado de las vistas
                          */
                         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                             callback(transactions, nil)
                         }
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
