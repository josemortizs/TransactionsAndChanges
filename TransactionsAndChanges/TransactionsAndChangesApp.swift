//
//  TransactionsAndChangesApp.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/22.
//

import SwiftUI

@main
struct TransactionsAndChangesApp: App {
        
    init() {
        
        let appearance = UINavigationBarAppearance()
        let proxy = UINavigationBar.appearance()

        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .red
        
        proxy.tintColor = .white
        proxy.standardAppearance = appearance
        proxy.scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TransactionsView()
            }
            .accentColor(.white)
        }
    }
}
