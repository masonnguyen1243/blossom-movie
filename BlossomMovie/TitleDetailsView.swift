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
                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geomatry.size.width, height: geomatry.size.height * 0.85)
                    
                    Text(title.name ?? title.title ?? "")
                        .font(.title)
                        .bold()
                        .padding(5)
                        .padding(.top, -20)
                    
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
