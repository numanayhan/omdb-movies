//
//  JSONDecoder.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
extension JSONDecoder {
    /// Convert json dictionary to Codable object
    ///
    /// - Parameters:
    ///   - json: Json dictionary.
    ///   - type: Type information.
    /// - Returns: Codable object
    /// - Throws: Error if failed
    static func decode<T: Codable>(_ json: [String: Any], to type: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try decode(data, to: type)
    }

    /// Convert json data to Codable object
    ///
    /// - Parameters:
    ///   - json: Json dictionary.
    ///   - type: Type information.
    /// - Returns: Codable object
    /// - Throws: Error if failed
    static func decode<T: Codable>(_ data: Data, to type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
