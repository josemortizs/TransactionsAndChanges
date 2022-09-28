//
//  TransactionRowView.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 28/9/22.
//

import SwiftUI

struct TransactionRowView: View {
    
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
                .foregroundColor(Color.blue)
                .font(.system(size: 32, weight: .regular))
            }
            
        }.padding()
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(sku: "T2006", count: 3) { }
    }
}
