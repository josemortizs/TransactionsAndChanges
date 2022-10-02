//
//  UserDefaultsTransactionsLocalRepository.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 29/9/22.
//

import Foundation

final class UserDefaultsTransactionsLocalRepository: TransactionsLocalRepositoryProtocol {
    
    func saveChanges(changes: [Change]) {
        
        let jsonEncoder = JSONEncoder()
        let userDefault = UserDefaults.standard

        do {
            let jsonData = try jsonEncoder.encode(changes)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            userDefault.setValue(json, forKey: "changes")
            
        } catch {
            print(error)
        }
    }
    
    func getChanges() -> [Change]? {
        
        let userDefault = UserDefaults.standard
        let json = userDefault.string(forKey: "changes") ?? ""
        let changes: [Change]? = StringDecoder.decode(model: Change.self, stringData: json)
        return changes
    }
    
    func saveTransactions(transactions: [Transaction]) {
        
        let jsonEncoder = JSONEncoder()
        let userDefault = UserDefaults.standard

        do {
            let jsonData = try jsonEncoder.encode(transactions)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            userDefault.setValue(json, forKey: "transactions")
            
        } catch {
            print(error)
        }
    }
    
    func getTransactions() -> [Transaction]? {
        
        let userDefault = UserDefaults.standard
        let json = userDefault.string(forKey: "transactions") ?? ""
        let transactions: [Transaction]? = StringDecoder.decode(model: Transaction.self, stringData: json)
        return transactions
    }
}
