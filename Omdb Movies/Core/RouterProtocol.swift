//
//  RouterProtocol.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

public protocol RouterProtocol: URLRequestConvertible {
    var baseURL: URL { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeout: TimeInterval { get }
    var task: HTTPTask { get }
}

extension RouterProtocol {
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL

        var request: URLRequest

        // Path
        if let path = path {
            request = URLRequest(url: url.appendingPathComponent(path))
        } else {
            request = URLRequest(url: url)
        }

        // Method
        request.httpMethod = method.rawValue

        // Headers
        request.allHTTPHeaderFields = headers.dictionary

        // Cache Policy
        request.cachePolicy = cachePolicy

        // Timeout
        request.timeoutInterval = timeout

        // Task
        switch task {
            case .requestPlain:
            break
        case .requestData(let data):
            request.httpBody = data
        case let .requestJSONEncodable(encodable):
            request = try request.encoded(encodable: encodable)
        case let .requestCustomJSONEncodable(encodable, encoder: encoder):
            request = try request.encoded(encodable: encodable, encoder: encoder)
        case let .requestParameters(parameters, parameterEncoding):
            request = try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)

        case let .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters):
            request.httpBody = bodyData
            let parameterEncoding = URLEncoding(destination: .queryString)
            request = try request.encoded(parameters: urlParameters, parameterEncoding: parameterEncoding)
        case let .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: bodyParameterEncoding, urlParameters: urlParameters):
            if let bodyParameterEncoding = bodyParameterEncoding as? URLEncoding, bodyParameterEncoding.destination != .httpBody {
                fatalError("Only URLEncoding.httpBody")
            }
            let bodyfulRequest = try request.encoded(parameters: bodyParameters, parameterEncoding: bodyParameterEncoding)
            let urlEncoding = URLEncoding(destination: .queryString)
            request = try bodyfulRequest.encoded(parameters: urlParameters, parameterEncoding: urlEncoding)
        }

        return request
    }
}

extension RouterProtocol {
    internal var hash: Int {
        var hasher = Hasher()
        hasher.combine(baseURL)
        hasher.combine(path)
        hasher.combine(method)
        hasher.combine(headers.dictionary)
        hasher.combine(cachePolicy)
        hasher.combine(timeout)
        return hasher.finalize()
    }
}
