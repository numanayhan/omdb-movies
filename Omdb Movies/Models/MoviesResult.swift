//
//  Movies.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
// MARK: - Media
struct FilterSearch {
    var isActive: Bool
    var account: Filters
}
class Filters {
    var types: String = ""
}

struct MoviesCategory : Decodable {
    let name: String
    let category: Category
    enum Category: Decodable {
      case star
      case comady
    }
}

extension MoviesCategory.Category: CaseIterable { }
extension MoviesCategory.Category: RawRepresentable {
  typealias RawValue = String

  init?(rawValue: RawValue) {
    switch rawValue {
    case "star": self = .star
    case "comady": self = .comady
    default: return nil
    }
  }
  var rawValue: RawValue {
    switch self {
    case .star: return "Star"
    case .comady: return "Comady"
    }
  }
}

// MARK: - Result
public struct MoviesResult : Codable, Equatable {
    var title : String?
    var year : String?
    var poster : String?
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
    }
    internal init(title: String?, year: String?, poster:String?){
        self.title = title
        self.year = year
        self.poster = poster
    }
}
