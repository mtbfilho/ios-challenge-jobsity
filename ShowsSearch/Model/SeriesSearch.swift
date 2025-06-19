//
//  SeriesSearch.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 17/06/25.
//

import Foundation
import Alamofire

let seriesSearchURL = "https://api.tvmaze.com/search/shows?q="
let episodesSearchURL: (Int) -> String = { "https://api.tvmaze.com/shows/\($0)/episodes" }

var allSeries: [Series] = []
var selectedSeries: Series? = nil

var allEpisodes: [Episode] = [] {
    didSet {
        var rowSection = -1
        var lastSeason = -1
        
        allEpisodes = allEpisodes.sorted { $0.season < $1.season }.map {
            if $0.season > lastSeason {
                lastSeason = $0.season
                rowSection += 1
            }
            
            var newEpisode = $0
            newEpisode.rowSection = rowSection
            
            return newEpisode
        }
    }
}
var selectedEpisode: Episode? = nil

func clearSeries(resultAction: @escaping () -> Void) {
    DispatchQueue.main.async {
        allSeries = []
        resultAction()
    }
}

func searchSeries(_ query: String, resultAction: @escaping () -> Void) {
    AF.request("\(seriesSearchURL)\(query)", method: .get).responseDecodable(of: [Series].self) { response in
        DispatchQueue.main.async {
            allSeries = response.value ?? []
            resultAction()
        }
    }
}

func clearEpisodes(resultAction: @escaping () -> Void) {
    DispatchQueue.main.async {
        allEpisodes = []
        resultAction()
    }
}

func searchEpisodes(_ showId: Int, resultAction: @escaping () -> Void) {
    AF.request("\(episodesSearchURL(showId))", method: .get).responseDecodable(of: [Episode].self) { response in
        DispatchQueue.main.async {
            allEpisodes = response.value ?? []
            resultAction()
        }
    }
}
