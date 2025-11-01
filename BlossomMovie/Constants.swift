//
//  Constants.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 30/10/25.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let upCommingString = "Upcomming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let trendingMoviesString = "Trending Movies"
    static let trendingTvString = "Treding TV"
    static let topRatedMoviesString = "Top Rated Movies"
    static let topRatedTvString = "Top Rated TV"
    
    static let homeIconString = "house.fill"
    static let upCommingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    static let testTitleUrl = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleUrl2 = "https://image.tmdb.org/t/p/w500/6CoRTJTmijhBLJTUNoVSUNxZMEI.jpg"
    static let testTitleUrl3 = "https://image.tmdb.org/t/p/w500/mbm8k3GFhXS0ROd9AD1gqYbIFbM.jpg"
    
    static let postedURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]) {
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.postedURLStart + path
            }
        }
            
    }
}

extension Text {
    func ghostButton() -> some View { 
        self
            .frame(width: 100, height: 50)
            .foregroundStyle( .buttonText)
            .bold()
            .background() {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder ,lineWidth: 5)
            }
    }
}
