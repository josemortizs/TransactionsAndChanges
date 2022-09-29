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
            case .listwithtransactionsOffline:
                listWithTransactionsOffline
            case .error:
                errorView
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
    
    var listWithTransactionsOffline: some View {
        ScrollView {
            
            Text("No hemos podido recuperar la información de las transacciones mediante nuestro servicio on-line, por favor, inténtalo de nuevo más tarde. Mientras tanto, te dejamos el listado que recuperamos en nuestra última sesión")
                .multilineTextAlignment(.center)
                .padding()
            
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
    
    var errorView: some View {
        Text("Ha habido un error, no hemos podido recuperar la información de transacciones online y tampoco tenemos datos guardados de otra sesión. Inténtelo de nuevo más tarde")
            .multilineTextAlignment(.center)
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

