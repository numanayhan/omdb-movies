//
//  KeyedDecodingContainer.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeBoolAsIntOrString(forKey key: Key) throws -> Bool {
        if let intValue = try? decode(Int.self, forKey: key) {
            return (intValue as NSNumber).boolValue
        } else if let stringValue = try? decode(String.self, forKey: key) {
            return (stringValue as NSString).boolValue
        } else {
            return try decode(Bool.self, forKey: key)
        }
    }

    func decodeBoolAsIntOrStringIfPresent(forKey key: Key) throws -> Bool? {
        if let intValue = try? decodeIfPresent(Int.self, forKey: key) {
            return (intValue as NSNumber).boolValue
        } else if let stringValue = try? decodeIfPresent(String.self, forKey: key) {
            return (stringValue as NSString).boolValue
        } else {
            return try decodeIfPresent(Bool.self, forKey: key)
        }
    }
}
