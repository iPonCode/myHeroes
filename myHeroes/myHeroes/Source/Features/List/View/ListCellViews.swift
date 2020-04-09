//  ListCellViews.swift
//  myHeroes
//
//  Created by Simón Aparicio on 09/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

// MARK: - Cell Views

struct StandardCellView: View {
    
    var charty: CharacterListItemDTO
    let defaultDescription = "No description, this is a text to supply it…"
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            CircleImageWidget(url: String(format: "%@.%@", String(charty.thumbnail!.path), String(charty.thumbnail!.thumbnailExtension)))

            VStack(alignment: .leading, spacing: 1){
                Text(String(charty.name ?? "default name"))
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.highlighted)
                    .fontWeight(.black)
                    .lineLimit(1)
                HStack {
                    VStack {
                        Text(charty.resultDescription?.isEmpty ?? true ? defaultDescription : String(charty.resultDescription ?? "default description"))
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.none)
                            .lineLimit(2)
                        Spacer()
                    }
                    // needed to push to the left description and image and icons view to the right
                    Spacer().layoutPriority(-10)
                    
                    VStack(alignment: .trailing, spacing: 1) {
                        Spacer() // push icons view down
                        VStack {
                            if charty.favourite {
                                Image(systemName: AppConfig.cellFav)
                                    .foregroundColor(.star)
                                .padding(.bottom, 4)
                            }
                            if charty.watched {
                                Image(systemName: AppConfig.cellWatched)
                                    .foregroundColor(.eye)
                                .padding(.bottom, 4)
                            }
                        } //hstack
                        
                    } //vstack
                    .foregroundColor(.secondary)
                    
                } //hstack
                HStack {
                    Spacer().layoutPriority(-10) // push to the right
                    Text(String(format: "%@ comics | %@ events | %@ series",
                                String(charty.comics.available),
                                String(charty.events?.count ?? 0),
                                String(charty.series?.count ?? 0)))
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Text(String(charty.id))
                        .font(.system(.caption, design: .rounded)).bold()
                } //hstack
            } //vstack
        } //hstack
        
    }
}

struct FeaturedCellView: View {
    
    var charty: CharacterListItemDTO
    let defaultDescription = "This character has an empty or nil description, this is a text to supply it…"

    var body: some View {
        ZStack {
            BackgroundImageWidget(url: String(format: "%@.%@", String(charty.thumbnail!.path), String(charty.thumbnail!.thumbnailExtension)))
            
            VStack(alignment: .center, spacing: 1){
                Text(String(charty.name ?? "default name"))
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.white)

                Text(charty.resultDescription?.isEmpty ?? true ? defaultDescription : String(charty.resultDescription ?? "default description"))
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .lineLimit(4)
                
                Spacer()
                HStack(alignment: .bottom, spacing: 5) {
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            if charty.favourite  { Image(systemName: AppConfig.cellFav) }
                            if charty.watched { Image(systemName: AppConfig.cellWatched) }
                        }
                        Text(String(charty.id))
                        Text(String(format: "%@ comics | %@ events | %@ series", String(charty.comics.items.count), String(charty.events?.count ?? 0), String(charty.series?.count ?? 0)))
                    }
                }
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.white)
            } //vstack
        .padding()
        } //zstack
    }
}

struct EmptyCharactersList: View {
    
    var error: ErrorResponse
    
    var body: some View {
        ZStack {
            Image("LaunchScreenTrans")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: AppConfig.screenWidth)
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.90)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 4) {
                Image(systemName: AppConfig.emptyListIcon)
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(.secondary)
                VStack {
                    Text(String("Loading list…"))
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                        .padding(.vertical)
                    Text(String(format:"%@", error.code))
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                    Text(String(format:"%@", error.message))
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                }
            }
            .padding()
        }
    }
}

// MARK: - Image Widgets

struct CircleImageWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data.isEmpty) ? UIImage(named: "placeholder")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 90, height: 90)
            .clipped()
            .cornerRadius(45) // half of widht to circle
    }
}

struct BackgroundImageWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data.isEmpty) ? UIImage(named: "placeholder")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(idealWidth: AppConfig.widthBackgroundImageWidget, maxHeight: AppConfig.maxHeightBackgroundImageWidget)
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .frame(idealWidth: AppConfig.widthBackgroundImageWidget, maxHeight: AppConfig.maxHeightBackgroundImageWidget)
                    .foregroundColor(.gray)
                    .opacity(0.55)
        )
    }
}
