//
//  TransactionsView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject var viewmodel = TransactionsViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            switch viewmodel.viewState {
            case .loading:
                loadingView
            case .listwithtransactions:
                listWithTransactions
            }
        }
        .navigationTitle(Text("Transactions And Changes"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewmodel.fetchTransactions()
        }
    }
    
    var loadingView: some View {
        Text("Estamos cargando los datos, por favor, sea paciente")
    }
    
    var listWithTransactions: some View {
        ScrollView {
            if let transactions = viewmodel.transactions {
                ForEach(transactions.keys.sorted(), id: \.self) { key in
                    Text(key)
                        .padding()
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
