//
//  TransactionsViewModel.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import Foundation

enum TransactionsViewState {
    case loading
    case listwithtransactions
    case listwithtransactionsOffline
}

final class TransactionsViewModel: ObservableObject {
    
    @Published var viewState: TransactionsViewState = .loading
    @Published var transactions: [String : [Transaction]]?
    
    public final func fetchTransactions() {
        
        TransactionsRepository.fetchTransactions { [weak self] data, error in
            
            if let data = data {
                
                DispatchQueue.init(label: "savedDataInOtherQueue").async {
                    UserDefaultsTransitionsLocalRepository.saveTransactions(transactions: data)
                }
                
                DispatchQueue.main.async {
                    self?.transactions = Dictionary(grouping: data, by: { $0.sku })
                    self?.viewState = .listwithtransactions
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                if let transactions = UserDefaultsTransitionsLocalRepository.getTransactions() {
                    self?.transactions = Dictionary(grouping: transactions, by: { $0.sku })
                    self?.viewState = .listwithtransactionsOffline
                } else {
                    //TODO: Gestionar viewState = .error
                }
            }
        }
    }
}
