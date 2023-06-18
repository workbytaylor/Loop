//
//  WebCoverView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI
import WebKit

struct StoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = true
    @State private var bookmark: Bool = false
    @Binding var link: String
    
    var body: some View {
        ZStack {
            WebView(url: URL(string: link)!, isLoading: $isLoading)
            
            if isLoading {
                ProgressView()
            }
        }
        //.navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.subheadline)
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                /*
                Button {
                    bookmark.toggle()
                } label: {
                    Image(systemName: bookmark == true ? "bookmark.fill" : "bookmark")
                        .font(.subheadline)
                }
                 */
                ShareLink(item: URL(string: "https://www.tracksmith.com")!) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.subheadline)
                }
            }
        }
    }
}


struct WebCoverView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StoryView(link: .constant("https://www.tracksmith.com"))
        }
    }
}


struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool
        
        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }
    }
}
