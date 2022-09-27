//
//  TransactionsView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear {
            
            let changes: [Change] = [
                Change(from: "EUR", to: "USD", rate: "0.96190127"),
                Change(from: "CAD", to: "EUR", rate: "0.75644943"),
                Change(from: "USD", to: "EUR", rate: "1.0398248"),
                Change(from: "EUR", to: "CAD", rate: "1.3217803")
            ]

            let transations: [Transaction] = [
                Transaction(sku: "T2006", amount: "10.00", currency: "USD"),
                Transaction(sku: "M2007", amount: "34.57", currency: "CAD"),
                Transaction(sku: "R2008", amount: "17.95", currency: "USD"),
                Transaction(sku: "T2006", amount: "7.63", currency: "EUR"),
                Transaction(sku: "B2009", amount: "21.23", currency: "USD")
            ]
            
            print(getChange(changes: changes, from: transations[0], to: "CAD") ?? 0)
            print(getChange(changes: changes, from: transations[1], to: "USD") ?? 0)
            print(getChange(changes: changes, from: transations[2], to: "EUR") ?? 0)
            
            TransactionsRepository.fetchTransactions { data, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
