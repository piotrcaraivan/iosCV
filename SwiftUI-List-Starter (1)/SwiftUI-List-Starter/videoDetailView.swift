//
//  videoDetailView.swift
//  SwiftUI-List-Starter
//
//  Created by Петр Караиван on 02.02.2023.
//

import SwiftUI

struct videoDetailView: View {
    
    var video: Video
    
    var body: some View {
        VStack(spacing: 18) {
            Spacer()
            
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 190)
                .cornerRadius(20)
            
            Text(video.title)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(4)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            HStack(spacing: 31) {
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(video.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Link(destination: video.url, label: {
                standartButton(title: "Watch Now")
            })
        }
    }
}

struct videoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        videoDetailView(video: VideoList.topTen.first!)
    }
}

struct standartButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .bold()
            .font(.title2)
            .frame(width: 290, height: 60)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}
