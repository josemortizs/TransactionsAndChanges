//
//  TransactionsViewModel.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import Foundation

enum ViewState {
    case loading
    case listwithtransactions
}

final class TransactionsViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .loading
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
                print(error.localizedDescription)
            }
        }
    }
}
