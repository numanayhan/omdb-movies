//
//  BaseResponse.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation

public struct BaseResponse<T: Decodable> {
    public var search: T?
    public var responseStatus: String?
    public var totalResults:String?
}

// MARK: - Codable
extension BaseResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case responseStatus = "Response"
        case totalResults = "totalResults"
    }

    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        search = try keyedContainer.decodeIfPresent(T.self, forKey: .search)
        responseStatus = try keyedContainer.decodeIfPresent(String.self, forKey: .responseStatus)
        totalResults = try keyedContainer.decodeIfPresent(String.self, forKey: .totalResults)
    }
}
