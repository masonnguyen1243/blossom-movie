//
//  TitleDetailsView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import SwiftUI

struct TitleDetailsView: View {
    let title: Title
    
    var body: some View {
        GeometryReader { geomatry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    YoutubePlayer(videoId: "pbiQKOmsIKg")
                        .aspectRatio(1.3, contentMode: .fit)
                    
                    Text(title.name ?? title.title ?? "")
                        .font(.title)
                        .bold()
                        .padding(5)
                    
                    Text(title.overview ?? "")
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    TitleDetailsView(title: Title.previewTitles[0])
}
