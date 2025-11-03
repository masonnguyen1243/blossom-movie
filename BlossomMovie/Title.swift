//
//  Title.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import SwiftData

struct TMDBAPIObject: Decodable {
    var results: [Title] = []
}

@Model
class Title: Decodable, Identifiable, Hashable {
    @Attribute(.unique) var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
            self.id = id
            self.title = title
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    static var previewTitles = [
        Title(id: 1, title: "Inception", name: "Inception", overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.", posterPath: Constants.testTitleUrl),
        Title(id: 2, title: "The Matrix", name: "The Matrix", overview: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.", posterPath: Constants.testTitleUrl2),
        Title(id: 3, title: "Interstellar", name: "Interstellar", overview: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.", posterPath: Constants.testTitleUrl3)
    ]
}
