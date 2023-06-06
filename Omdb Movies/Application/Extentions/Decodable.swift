//
//  Decodable.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
extension Decodable {
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }

    init?(JSONString: String?) {
        guard let json = JSONString,
              let jsonData = json.data(using: .utf8),
              let anInstance = try? JSONDecoder().decode(Self.self, from: jsonData) else {
            return nil
        }
        self = anInstance
    }
}
