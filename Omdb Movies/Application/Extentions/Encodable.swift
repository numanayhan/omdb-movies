//
//  Encodable.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
extension Encodable {
    func toString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }

    func asDictionary() -> [String: Any?]? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any?] else {
            return nil
        }
        return dictionary
    }
}
