//
//  VideoListView.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct VideoListView: View {
    
    var videos: [Video] = VideoList.topTen
    
    var body: some View {
        NavigationView{
            List(videos, id: \.id) { video in
                NavigationLink(destination: videoDetailView(video: video), label: {
                    videoCell(video: video)
                })
            }
            .navigationTitle("Sean's Top 10")
        }
    }
}

struct videoCell: View {
    
    var video: Video
    var body: some View {
        HStack {
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(4)
                .padding(.vertical, 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(video.title)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
