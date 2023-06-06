//
//  NetworkClient.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkCompletion<T: Decodable> = (Result<T, NetworkError>) -> Void

public protocol NetworkClientProtocol {
    var session: NetworkSession { get }

    @discardableResult
    func request<R: RouterProtocol, T: Decodable>(
        router: R,
        model: T.Type,
        completion: @escaping NetworkCompletion<T>
    ) -> Request

    func cancel(
        request: Request,
        completion: (() -> Void)?
    )
}

open class NetworkClient: NetworkClientProtocol {
    @discardableResult
    open func request<R: RouterProtocol, T: Decodable>(
        router: R,
        model: T.Type,
        completion: @escaping NetworkCompletion<T>
    ) -> Request {
        switch router.task {
        case .requestPlain,
             .requestData,
             .requestJSONEncodable,
             .requestCustomJSONEncodable,
             .requestParameters,
             .requestCompositeData,
             .requestCompositeParameters:
            let request = session.request(router, interceptor: nil)
            let validatedRequest = request.validate()

            validatedRequest.responseDecodable(of: T.self) { responseData in
                switch responseData.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    self.handle(error: error, responseData: responseData, completion: completion)
                }
            }
            return validatedRequest
        default:
           break
        }
    }

    open func cancel(request: Request, completion: (() -> Void)?) {
        session.withAllRequests { requests in
            requests.forEach { sessionRequest in
                if sessionRequest.request == request.request {
                    sessionRequest.cancel()
                }
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    public var session: NetworkSession
    public init(session: NetworkSession = NetworkSession()) {
        self.session = session
    }
}

extension NetworkClient {
    func handle<T: Decodable>(
        error: AFError,
        responseData: AFDataResponse<T>,
        completion: @escaping NetworkCompletion<T>
    ) {
        switch responseData.response?.statusCode {
        case 400: // Bad Request
            completion(.failure(.badRequest(responseData.data)))
        case 401: // Authorization
            completion(.failure(.auth))
        case 403: // Forbidden
            completion(.failure(.forbidden))
        case 404: // Not Found
            completion(.failure(.notFound))
        case 405: // Invalid Method
            completion(.failure(.invalidMethod))
        case 408, 500: // Timeout
            completion(.failure(.timeout))
        case 499:
            completion(.failure(.requestCancelled))
        default:
            guard NetworkReachabilityManager()?.isReachable ?? false else {
                completion(.failure(.noInternetConnection))
                return
            }
            completion(.failure(.error(error)))
        }
    }
}
