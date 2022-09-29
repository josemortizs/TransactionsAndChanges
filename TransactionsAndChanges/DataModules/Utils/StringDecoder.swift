//
//  StringDecoder.swift
//  TransactionsAndChanges
//
//  Created by Jose Manuel Ortiz Sanchez on 29/9/22.
//

import Foundation

class StringDecoder {
    
    static func decode<T: Codable>(model: T.Type, stringData: String) -> T? {
        
        guard let data = stringData.data(using: .utf8) else {
            return nil
        }
                
        guard let genericModelData = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return genericModelData
    }

    static func decode<T: Codable>(model: T.Type, stringData: String) -> [T]? {
        
        guard let data = stringData.data(using: .utf8) else {
            return nil
        }
                
        guard let genericModelData = try? JSONDecoder().decode([T].self, from: data) else {
            return nil
        }
        
        return genericModelData
    }
}
