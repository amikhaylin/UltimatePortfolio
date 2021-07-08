//
//  Bundle-Decodable.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 05.07.2021.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Faled to decode \(file) from bundle due to missing key \(key.stringValue) not found - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Faled to decode \(file) from bundle due to type missmatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Faled to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Faled to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Faled to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
