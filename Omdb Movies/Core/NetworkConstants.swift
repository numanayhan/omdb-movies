//
//  NetworkConstants.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
struct NetworkConstants {
    /// The keys for HTTP header fields
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    /// The values for HTTP header fields
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case fromEncoded = "application/x-www-form-urlencoded"
    }
}
