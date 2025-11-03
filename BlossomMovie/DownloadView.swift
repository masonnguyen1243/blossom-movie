//
//  DownloadView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 3/11/25.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query(sort: \Title.title) var saveTItles: [Title]
    
    var body: some View {
        NavigationStack {
            if saveTItles.isEmpty {
                Text("No downloaded titles yet.")
                    .padding()
                    .font(.title3)
                    .bold()
            }else {
                VerticalListView(titles: saveTItles, canDelete: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
