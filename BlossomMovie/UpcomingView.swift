//
//  UpcomingView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 2/11/25.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            switch viewModel.upcomingStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height)
            case .success:
                VerticalListView(titles: viewModel.upcomingMovies)
            case .failure(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getUpComingMovies()
        }
    }
}

#Preview {
    UpcomingView()
}
