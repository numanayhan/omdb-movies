//
//  NetworkContants.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire
enum ServiceContants {
    public static let url =  "https://www.omdbapi.com"
    public static let key = "c0b88865"
}

struct NetworkContants {
    public static var baseURL = ServiceContants.url
    public static var baseHeaderParams: HTTPHeaders {
        return HTTPHeaders()
    }
    public static var timeout: TimeInterval = 60
    public static var baseQueryParams: [String: Any] = ["apikey": ServiceContants.key] 
}
