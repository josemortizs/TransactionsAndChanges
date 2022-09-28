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
}

final class ChangesViewModel: ObservableObject {
    
    @Published var viewState: ChangesViewState = .listwithtransactions
    @Published var transactions: [Transaction] = []
    @Published var changes: [Change] = []
    
    public final func fetchChanges() {
        
        TransactionsRepository.fetchChanges { [weak self] data, error in
            
            if let data = data {
                print("*****************")
                data.forEach { change in
                    print(change)
                }
                print("*****************")
                self?.changes = data
                self?.viewState = .listwithtransactionsAndChanges
            }
            
            if let error = error {
                //TODO: Implemetar gestión de errores
                print(error.localizedDescription)
            }
        }
    }
}
