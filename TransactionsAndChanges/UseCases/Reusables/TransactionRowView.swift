//
//  TransactionRowView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import SwiftUI

struct TransactionRowView: View {
    
    let amount: Double
    let currencyFrom: String
    let currencyTo: String
    let amountFinal: Double?
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                
                Text(String(format: "%.2f", amount))
                
                Spacer()
                
                Text(currencyFrom)
                
                Spacer()
                
                Text(currencyTo)
                
                Spacer()
                
                if let amountFinal = amountFinal {
                    Text(String(format: "%.2f", amountFinal))
                } else {
                    ProgressView()
                }
                
            }.padding()
            
            Divider()
        }
    }
}

struct TransactionLinkRowView: View {
    
    let sku: String
    let count: Int
    
    let onIconTap: () -> ()
    
    var body: some View {
        HStack(alignment: .center) {
            
            Text(sku)
                .bold()
            
            Spacer()
            
            Text("Número de transacciones: \(count)")
                .font(Font.system(size: 10))
            
            Spacer()
            
            Button {
                onIconTap()
            } label: {
                Image(systemName: "arrow.forward.circle.fill")
                .symbolRenderingMode(.monochrome)
                .foregroundColor(Color.red)
                .font(.system(size: 32, weight: .regular))
            }
            
        }.padding()
    }
}
