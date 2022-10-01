//
//  TransactionsRepositoryProtocol.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 29/9/22.
//

import Foundation

protocol TransactionsRepositoryProtocol {
    func fetchChanges(callback: @escaping (_ data: [Change]?, _ error: Error?) -> Void)
    func fetchTransactions(callback: @escaping (_ data: [Transaction]?, _ error: Error?) -> Void)
}


protocol TransactionsLocalRepositoryProtocol {
    func saveChanges(changes: [Change])
    func getChanges() -> [Change]?
    func saveTransactions(transactions: [Transaction])
    func getTransactions() -> [Transaction]?
}
