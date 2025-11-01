//
//  YoutubePlayer.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseUrl = APIConfig.shared?.youtubeBaseUrl
    
    func makeUIView(context: Context) -> some WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseUrl,
              let baseURL = URL(string: baseURLString) else {return}
        
        let fullURL = baseURL.appending(path: videoId)
        webView.load(URLRequest(url: fullURL))
    }
}
    
