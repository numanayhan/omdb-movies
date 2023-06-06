//
//  MoviesAPI.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

public enum MoviesAPI: RouterProtocol {
    case comedy
    case search(sender: String)

    public var baseURL: URL {
        guard let url = URL(string: "\(NetworkContants.baseURL)") else {
            fatalError("Invalid URL")
        }
        return url
    }

    public var path: String? {
        switch self {
            case .comedy: return nil
            case .search: return nil
        }
    }

    public var method: HTTPMethod {
        switch self {
            case .comedy:
            return .get
            case .search:
            return .get
        }
    }

    public var headers: HTTPHeaders { 
        return NetworkContants.baseHeaderParams
    }

    public var task: HTTPTask {
        var parameters = NetworkContants.baseQueryParams
        switch self {
            case .search(let senderKey):
            parameters.updateValue(senderKey, forKey: "s")
            case .comedy:
                break
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    public var timeout: TimeInterval {
        return NetworkContants.timeout
    }
}
