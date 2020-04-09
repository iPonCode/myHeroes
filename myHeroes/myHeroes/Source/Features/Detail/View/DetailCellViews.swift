//  DetailCellViews.swift
//  myHeroes
//
//  Created by Simón Aparicio on 09/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct ComicCellView: View {

    var name: String
    var resourceURI: String

    var body: some View {

        HStack(alignment: .center, spacing: 8) {

            Image(systemName: AppConfig.cellLink)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 1){
                Text(name)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.highlighted)
                    .fontWeight(.bold)
                    .lineLimit(1)

                HStack {
                    VStack {
                        Text(resourceURI)
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Spacer()
                    }
                    // needed to push to the left description and image and icons view to the right
                    Spacer().layoutPriority(-10)
                } //hstack
            } //vstack
        } //hstack

    }
}

struct EmptyComicsItemList: View {

    var type: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: AppConfig.emptyListIcon)
                .foregroundColor(.secondary)
            Text(String(format:"There are not %@ for this Character", type))
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct HeaderImageWidget: View {

    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {

        Image(uiImage: (imageLoader.data.isEmpty) ?
                            UIImage(named: "placeholder")! :
                            UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: AppConfig.screenWidth, height: AppConfig.maxHeightHeaderImageWidget)
//            .frame(width: AppConfig.screenWidth)
            .overlay(
                Rectangle()
                    .frame(width: AppConfig.screenWidth, height: AppConfig.maxHeightHeaderImageWidget)
//                    .frame(width: AppConfig.screenWidth)
                    .foregroundColor(.gray)
                    .opacity(0.45)
        )
    }
}
