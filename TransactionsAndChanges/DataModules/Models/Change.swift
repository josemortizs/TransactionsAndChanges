//
//  Change.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import Foundation

struct Change: Codable {
    let from: String
    let to: String
    let rate: String
    var operableRate: Double? {
        Double(self.rate)
    }
}
