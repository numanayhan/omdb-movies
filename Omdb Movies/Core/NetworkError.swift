//
//  NetworkError.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case decoding
    case encoding
    case missingURL
    case badRequest(_ data: Data?)
    case auth
    case forbidden
    case notFound
    case invalidMethod
    case timeout
    case requestCancelled
    case noInternetConnection
    case unknown
    case error(AFError)
}
