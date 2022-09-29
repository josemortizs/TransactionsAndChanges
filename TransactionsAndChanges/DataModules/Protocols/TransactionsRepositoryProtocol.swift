//
//  TransactionsRepositoryProtocol.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 29/9/22.
//

import Foundation

protocol TransactionsRepositoryProtocol {
    static func fetchChanges(callback: @escaping (_ data: [Change]?, _ error: Error?) -> Void)
    static func fetchTransactions(callback: @escaping (_ data: [Transaction]?, _ error: Error?) -> Void)
}


protocol TransactionsLocalRepositoryProtocol {
    static func saveChanges(changes: [Change])
    static func getChanges() -> [Change]?
    static func saveTransactions(transactions: [Transaction])
    static func getTransactions() -> [Transaction]?
}
