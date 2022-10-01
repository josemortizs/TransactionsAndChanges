//
//  ChangesViewModel.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import Foundation

enum ChangesViewState {
    case listwithtransactions
    case listwithtransactionsAndChanges
    case listwithtransactionsAndChangesOffline
    case error
}

final class ChangesViewModel: ObservableObject {
    
    @Published var viewState: ChangesViewState = .listwithtransactions
    @Published var transactions: [Transaction] = []
    @Published var changes: [Change] = []
    
    var totalTransactionsInEUR: Double {
        transactions.reduce(0) { partialResult, transaction in
            partialResult + (getChange(changes: changes, from: transaction, to: "EUR") ?? 0)
        }
    }
    
    var titleView: String {
        if let firstTransaction = transactions.first {
            return firstTransaction.sku
        } else {
            return "Transactions And Changes"
        }
    }
    
    let transactionsRepository: TransactionsRepositoryProtocol
    let transactionsLocalRepository: TransactionsLocalRepositoryProtocol
    
    init(transactionsRepository: TransactionsRepositoryProtocol, transactionsLocalRepository: TransactionsLocalRepositoryProtocol) {
        self.transactionsRepository = transactionsRepository
        self.transactionsLocalRepository = transactionsLocalRepository
    }
    
    public final func fetchChanges() {
        
        self.transactionsRepository.fetchChanges { [weak self] data, error in
            
            if let data = data {
                
                DispatchQueue.init(label: "savedDataInOtherQueue").async {
                    self?.transactionsLocalRepository.saveChanges(changes: data)
                }
                
                self?.changes = data
                self?.viewState = .listwithtransactionsAndChanges
            }
            
            if let error = error {
                print(error.localizedDescription)
                if let changes = self?.transactionsLocalRepository.getChanges() {
                    self?.changes = changes
                    self?.viewState = .listwithtransactionsAndChangesOffline
                } else {
                    self?.viewState = .error
                }
            }
        }
    }
}
