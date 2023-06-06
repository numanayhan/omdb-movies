//
//  SearchViewModel.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesListProtocol {
    func fetchSearchMovieList(searchParams:String?, completion: @escaping NetworkCompletion<BaseResponse<[MoviesResult]>>)
}

final class MoviesListWorker:MoviesListProtocol {

    private let service: NetworkClientProtocol
    init(service: NetworkClientProtocol = NetworkClient()) {
        self.service = service
    } 
    func fetchSearchMovieList(searchParams:String? = nil , completion: @escaping NetworkCompletion<BaseResponse<[MoviesResult]>>) {
        service.request(
            router: MoviesAPI.search(sender: searchParams ?? ""),
            model: BaseResponse<[MoviesResult]>.self
        ) { result in
            completion(result)
        }
    }
}
