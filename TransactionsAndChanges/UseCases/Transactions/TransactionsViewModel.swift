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
}

final class TransactionsViewModel: ObservableObject {
    
    @Published var viewState: TransactionsViewState = .loading
    @Published var transactions: [String : [Transaction]]?
    
    public final func fetchTransactions() {
        
        TransactionsRepository.fetchTransactions { [weak self] data, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    self?.transactions = Dictionary(grouping: data, by: { $0.sku })
                    self?.viewState = .listwithtransactions
                }
            }
            
            if let error = error {
                //TODO: Implemetar gestión de errores
                print(error.localizedDescription)
            }
        }
    }
}
