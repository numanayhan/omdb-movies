//
//  Movies.swift
//  Omdb Movies
//
//  Created by na on 6.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit

typealias MoviesResponse = Movies.Stars.Response
typealias MoviesList = Movies.Stars.Response.MoviesList
typealias MoviesVM = Movies.Stars.ViewModel

enum Movies {

    enum Stars {
        struct Request {
        }
        struct Response {
            var moviesList: MoviesList?
            public struct MoviesList: Codable, Equatable {
                public let search: [MoviesResult]?
                enum CodingKeys: String, CodingKey {
                    case search = "Search"
                }
                public init(
                    search: [MoviesResult]? = nil
                ) {
                    self.search = search
                }
            }
        }

        struct ViewModel {
            var size: CGSize
            var sectionInset: UIEdgeInsets
            var minimumLineSpacing: CGFloat
            var minimumInteritemSpacing: CGFloat
            var numberOfItems: Int
            var title:String
            var lists: [MoviesResult]?
        }
    }
}
