//
//  Request.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkRequest: RouterProtocol {
    var baseURL: URL
    var path: String?
    var method: HTTPMethod
    var headers: HTTPHeaders
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    var timeout: TimeInterval = 60.0
    var task: HTTPTask
}
