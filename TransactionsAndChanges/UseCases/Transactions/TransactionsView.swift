//
//  TransactionsView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject var viewmodel = TransactionsViewModel()
    
    @State var goToDetail: Bool = false
    @State var transactionsToSend: [Transaction] = []
    
    var body: some View {
        VStack(alignment: .center) {
            
            switch viewmodel.viewState {
            case .loading:
                loadingView
            case .listwithtransactions:
                listWithTransactions
            }
            
            navigationLinks
        }
        .animation(.easeIn(duration: 1), value: viewmodel.viewState)
        .navigationTitle(Text("Transactions And Changes"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewmodel.fetchTransactions()
        }
    }
    
    var loadingView: some View {
        Text("Estamos cargando los datos, por favor, sea paciente")
            .multilineTextAlignment(.center)
    }
    
    var listWithTransactions: some View {
        ScrollView {
            if let transactions = viewmodel.transactions {
                ForEach(transactions.keys.sorted(), id: \.self) { key in
                    if let transactionsOfKey = viewmodel.transactions?[key] {
                        TransactionLinkRowView(sku: key, count: transactionsOfKey.count) {
                            self.transactionsToSend = transactionsOfKey
                            self.goToDetail.toggle()
                        }
                    }
                }
            }
        }
    }
    
    var navigationLinks: some View {
        VStack {
            NavigationLink(destination: ChangesView(transactions: self.transactionsToSend), isActive: self.$goToDetail) {
                EmptyView()
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}

