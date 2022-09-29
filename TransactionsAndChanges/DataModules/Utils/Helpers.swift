//
//  Helpers.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import Foundation

func getChange(changes: [Change], from transaction: Transaction, to currency: String) -> Double? {
    
    guard let transactionAmount = transaction.operableAmount else {
        return nil
    }
        
    if transaction.currency == currency {
        return transactionAmount
    }
    
    if let change = changes.first(where: { change in
        transaction.currency == change.from && change.to == currency
    }), let rate = change.operableRate {
        return transactionAmount * rate
    }
    
    
    var amount: Double?
    let possiblesFrom: [Change] = changes.filter { $0.from == transaction.currency }
    let possiblesTo: [Change] = changes.filter { $0.to == currency }
    
    possiblesFrom.forEach { changeFrom in
        possiblesTo.forEach { changeTo in
            if changeFrom.to == changeTo.from && changeTo.to == currency {
                if let rateFrom = changeFrom.operableRate, let rateTo = changeTo.operableRate {
                    amount = transactionAmount * rateFrom * rateTo
                }
            }
        }
    }
    
    return amount
}
