//
//  NetworkLogger.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let headers = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let url = request.request.flatMap { $0.url?.absoluteString } ?? "None"
        let method = request.request.flatMap { $0.httpMethod } ?? "None"
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let path = request.request.flatMap { $0.url?.path } ?? "None"
        let parameters = request.request.flatMap { $0.url?.queryParameters?.jsonString(prettify: true) } ?? "None"
        let logString = """
        🌩 ↗️ Request Started
        🌩 ↗️ Request: (\(method)) \(url)
        🌩 ↗️ Path: \(path)
        🌩 ↗️ Parameters: \(parameters)
        🌩 ↗️ Body: \(body)
        🌩 ↗️ Headers: \(headers)
        """
        print(logString)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        let headers = response.response?.allHeaderFields.jsonString(prettify: true) ?? "None"
        let url = request.request.flatMap { $0.url?.absoluteString } ?? "None"
        let method = request.request.flatMap { $0.httpMethod } ?? "None"
        let statusCode = response.response?.statusCode.string ?? "None"
        let logString = """
        🌩 ↘️ Response Received
        🌩 ↘️ Response: (\(statusCode)) [(\(method))] \(url)
        🌩 ↘️ Headers: \(headers)
        🌩 ↘️ Received: \(response.debugDescription)
        🌩 ↘️ Data: \(String(describing: response.data?.prettyPrintedJSONString))
        """

        print(logString)
    }
}
