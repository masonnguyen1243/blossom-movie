//
//  HomeView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 30/10/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let viewModel = ViewModel()
    
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: .clear, location: 0.8),
                                                Gradient.Stop(color: .gradient, location: 1)],
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.85)
                            
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                } label: {
                                    Text(Constants.playString)
                                        .ghostButton()
                                }
                                
                                Button {
                                    modelContext.insert(viewModel.heroTitle)
                                    try? modelContext.save()
                                } label: {
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                }
                            }
                            
                            HorizontalListView(header: Constants.trendingMoviesString, titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTvString, titles: viewModel.trendingTV){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMoviesString, titles: viewModel.topRatedMovies){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTvString, titles: viewModel.topRatedTV){ title in
                                titleDetailPath.append(title)
                            }
                        }
                    case .failure(underlyingError: let error):
                        Text(error.localizedDescription)
                            .errorMessage()
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .task {
                    await viewModel.getTitle()
                }
                .navigationDestination(for: Title.self) { title in
                        TitleDetailsView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
