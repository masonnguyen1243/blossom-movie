//
//  UpcomingView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 2/11/25.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        VerticalListView(titles: Title.previewTitles)
    }
}

#Preview {
    UpcomingView()
}
