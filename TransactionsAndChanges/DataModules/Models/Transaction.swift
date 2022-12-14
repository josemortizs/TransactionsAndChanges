//
//  Transaction.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let sku: String
    let amount: String
    let currency: String
    var operableAmount: Double? {
        Double(self.amount)
    }
    var id: Int {
        UUID().hashValue
    }
}
