//
//  TitleDetailsView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import SwiftUI

struct TitleDetailsView: View {
    let title: Title
    var titleName: String {
        return (title.name ?? title.title) ?? ""
    }
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geomatry in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geomatry.size.width, height: geomatry.size.height)
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titleName)
                            .font(.title)
                            .bold()
                            .padding(5)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                    }
                }
            case .failure(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleDetailsView(title: Title.previewTitles[0])
}
