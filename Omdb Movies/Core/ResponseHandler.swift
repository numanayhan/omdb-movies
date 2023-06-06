//
//  ResponseHandler.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation

class ResponseHandler {
    static func validatedResponse<T: Decodable>(
        _ result: Result<BaseResponse<T>, NetworkError>,
        dismissOnFailure: Bool
    ) -> BaseResponse<T> {
        switch result {
        case .success(let response):
            var baseResponse = response
            return baseResponse
        case .failure(let error):
            var baseResponse = BaseResponse<T>()
            var message: String?
            #if DEBUG
            message = error.localizedDescription
            #endif
            switch error {
            case .decoding:
                message = "decoding"
            case .encoding:
                message = "encoding"
            case .missingURL:
                message = "missingURL"
            case .badRequest:
                message = "badRequest"
            case .auth:
                message = error.localizedDescription
            case .forbidden:
                message = "forbidden"
            case .notFound:
                message = "notFound"
            case .invalidMethod:
                message = "invalidMethod"
            case .timeout:
                message = error.localizedDescription
            case .requestCancelled:
                message = error.localizedDescription
                return baseResponse
            case .noInternetConnection:
                message = error.localizedDescription
            case .unknown:
                message = "Unknown"
            case .error:
                message = "Error"
            } 
            return baseResponse
        }
    }
}
