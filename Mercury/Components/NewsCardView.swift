//
//  NewsCardView.swift
//  Mercury
//
//  Created by Nilakshi Roy on 2023-05-22.
//

import SwiftUI

struct NewsCardView: View {
    let story: Story
    //@State var bookmark: Bool = false
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            AsyncImage(url: URL(string: story.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.bottom, 4)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .frame(height: 220)
                    .padding(.bottom, 4)
                    .foregroundStyle(.secondary)
            }
            //TODO: placeholder if image does not load / exist
            
            Text(story.title)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(alignment: .bottom, spacing: 20) {
                Text(story.displayLink)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .foregroundColor(.primary)
                Spacer()
                /*
                Button {
                    bookmark.toggle()
                } label: {
                    Image(systemName: bookmark == true ? "bookmark.fill" : "bookmark")
                }
                 */
                ShareLink(item: story.link) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

/*
struct NewsCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewsCardView(item: )
    }
}
*/
