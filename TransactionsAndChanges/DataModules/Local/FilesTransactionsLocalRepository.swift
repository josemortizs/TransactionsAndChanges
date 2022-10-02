//
//  FilesTransactionsLocalRepository.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 2/10/22.
//

import Foundation

final class FilesTransactionsLocalRepository: TransactionsLocalRepositoryProtocol {
    
    func saveChanges(changes: [Change]) {
        
        let jsonEncoder = JSONEncoder()
        let url = getDocumentsDirectory().appendingPathComponent("changes.txt")
        
        do {
            let jsonData = try jsonEncoder.encode(changes)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            if let json = json {
                try json.write(to: url, atomically: true, encoding: .utf8)
            }
            
        } catch {
            print(error)
        }
    }
    
    func getChanges() -> [Change]? {
        
        let url = getDocumentsDirectory().appendingPathComponent("changes.txt")
        
        do {
            let json = try String(contentsOf: url)
            let changes: [Change]? = StringDecoder.decode(model: Change.self, stringData: json)
            return changes
        } catch {
            return nil
        }
    }
    
    func saveTransactions(transactions: [Transaction]) {
        let jsonEncoder = JSONEncoder()
        let url = getDocumentsDirectory().appendingPathComponent("transactions.txt")
        
        do {
            let jsonData = try jsonEncoder.encode(transactions)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            if let json = json {
                try json.write(to: url, atomically: true, encoding: .utf8)
            }
            
        } catch {
            print(error)
        }
    }
    
    func getTransactions() -> [Transaction]? {
        
        let url = getDocumentsDirectory().appendingPathComponent("transactions.txt")
        
        do {
            let json = try String(contentsOf: url)
            let transactions: [Transaction]? = StringDecoder.decode(model: Transaction.self, stringData: json)
            return transactions
        } catch {
            return nil
        }
    }
    
    
}
