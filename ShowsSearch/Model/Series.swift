//
//  Series.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 17/06/25.
//

import Foundation
 
struct Series: Decodable {
    var show: Show
}

struct Show: Decodable {
    var id: Int
    var name: String
    var image: Image
    var summary: String
    var schedule: Schedule
    var genres: [String]
}

struct Image: Decodable {
    var medium: String
}

struct Schedule: Decodable {
    var time: String
    var days: [String]
}

struct Episode: Decodable {
    var name: String
    var season: Int
    var image: Image
    var number: Int
    var summary: String
    var rowSection = -1
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        season = try values.decode(Int.self, forKey: .season)
        image = try values.decode(Image.self, forKey: .image)
        number = try values.decode(Int.self, forKey: .number)
        summary = try values.decode(String.self, forKey: .summary)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case season
        case image
        case number
        case summary
    }
}

extension [Episode] {
    subscript(section: Int, row: Int) -> Episode {
        self.filter { $0.rowSection == section }[row]
    }
}
