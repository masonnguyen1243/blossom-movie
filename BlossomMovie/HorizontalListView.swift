//
//  HorizontalListView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 30/10/25.
//

import SwiftUI

struct HorizontalListView: View {
    
    let header: String
    let titles = [Constants.testTitleUrl, Constants.testTitleUrl2, Constants.testTitleUrl3]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(titles, id: \.self) { title in
                        AsyncImage(url: URL(string: title)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                    }
                }
            }
        }
        .frame(height: 250)
        .padding(10)
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMoviesString)
}
