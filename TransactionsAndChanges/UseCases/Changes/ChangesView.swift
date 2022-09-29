//
//  ChangesView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import SwiftUI

struct ChangesView: View {
    
    @StateObject var viewmodel = ChangesViewModel()
    
    var transactions: [Transaction]
    
    var body: some View {
        VStack(alignment: .center) {
            switch viewmodel.viewState {
            case .listwithtransactions:
                listwithtransactions
            case .listwithtransactionsAndChanges:
                listwithtransactionsAndChanges
            case .listwithtransactionsAndChangesOffline:
                listwithtransactionsAndChangesOffline
            }
        }
        .animation(.easeIn(duration: 1), value: viewmodel.viewState)
        .navigationTitle(Text(viewmodel.titleView))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewmodel.transactions = transactions
            self.viewmodel.fetchChanges()
        }
    }
    
    var listwithtransactions: some View {
        ScrollView {
            
            Text("Recuperando los tipos de cambio más recientes...")
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(viewmodel.transactions) { transaction in
                if let amount = transaction.operableAmount {
                    TransactionRowView(amount: amount, currencyFrom: transaction.currency, currencyTo: "EUR", amountFinal: nil)
                }
            }
        }
    }
    
    var listwithtransactionsAndChanges: some View {
        ScrollView {
            
            Text("Total transacciones: \(String(format: "%.2f", viewmodel.totalTransactionsInEUR)) EUR")
                .bold()
                .padding()
            
            ForEach(viewmodel.transactions) { transaction in
                if let amount = transaction.operableAmount, let amountWithConversion = getChange(changes: viewmodel.changes, from: transaction, to: "EUR") {
                    TransactionRowView(amount: amount, currencyFrom: transaction.currency, currencyTo: "EUR", amountFinal: amountWithConversion)
                }
            }
        }
    }
    
    var listwithtransactionsAndChangesOffline: some View {
        ScrollView {
            
            Text("No hemos podido recuperar la información de los tipos de cambio actual mediante nuestro servicio on-line, por favor, inténtalo de nuevo más tarde. Mientras tanto, te dejamos el cálculo en base a los datos que recuperamos en nuestra última sesión")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Total transacciones: \(String(format: "%.2f", viewmodel.totalTransactionsInEUR)) EUR")
                .bold()
                .padding()
            
            ForEach(viewmodel.transactions) { transaction in
                if let amount = transaction.operableAmount, let amountWithConversion = getChange(changes: viewmodel.changes, from: transaction, to: "EUR") {
                    TransactionRowView(amount: amount, currencyFrom: transaction.currency, currencyTo: "EUR", amountFinal: amountWithConversion)
                }
            }
        }
    }
}

struct ChangesView_Previews: PreviewProvider {
    static var previews: some View {
        ChangesView(transactions: [])
    }
}
