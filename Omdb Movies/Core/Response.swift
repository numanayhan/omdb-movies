//
//  Response.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
open class NetworkResponse<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String: String]()
        for case let (key, value) as (String, String) in rawHeader {
            header[key] = value
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}
