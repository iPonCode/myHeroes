//  DetailView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct DetailView: View {

//    let detailsTitle = "Details"
//    let defaultName = "Nameless Character"
    let defaultDescription = """
                             This character has an empty or nil description, this is a text to supply it. If you are going to use a passage of Lorem Ipsum…
                             """

    @ObservedObject var viewModel: DetailViewModel
    @State private var selectedItemList = ItemListType.comics
    
    init(id: Int) {
        self.viewModel = DetailViewModel(id)
    }
    
    var body: some View {
        
//        ScrollView(showsIndicators: true) {
            VStack {
                VStack{
                    ZStack{
                        ZStack(alignment: .bottom) {
                            HeaderImageWidget(url: String(format: "%@.%@", String((viewModel.chartys[0].thumbnail.path)), String((viewModel.chartys[0].thumbnail.thumbnailExtension)))
                            )
                            Picker(selection: $selectedItemList, label: Text("Select an items list")){
                                ForEach(ItemListType.allCases, id: \.self){ itemListType in
                                    Text(itemListType.description)
                                }
                            }
                            .padding(.horizontal)
                            .background(Color.segmentedPickerBackground)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        VStack(alignment: .center, spacing: 1) {
                            Spacer()
                            HStack(alignment: .top, spacing: 5) {
                                Spacer()
                                Text(String(viewModel.chartys[0].id))
                            }
                            Text(viewModel.chartys[0].resultDescription.isEmpty ? defaultDescription : String(viewModel.chartys[0].resultDescription))
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                //.lineLimit(4)
                        }
                        .padding()
                        .padding(.vertical, 50)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                    } //zstack
                }
                VStack{
                    List(selectedItemList.selectedItemList(viewModel.chartys[0]), id: \.id) { item in
                        ComicCellView(name: item.id, resourceURI: item.resourceURI)
                    }
                } // vstack
                .padding(.horizontal)
            } // vstack
            .navigationBarTitle(Text(String(format: "%@", viewModel.chartys[0].name)), displayMode: .inline)
//            .navigationBarTitle(Text(String(format: "%d  %@", viewModel.chartys[0].id, detailsTitle)), displayMode: .inline)

//        } // scrollview
    } // body

}

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


struct HeaderImageWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data.count == 0) ? UIImage(named: "placeholder")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: AppConfig.screenWidth)
            .overlay(
                Rectangle()
                    .frame(width: AppConfig.screenWidth)
                    .foregroundColor(.gray)
                    .opacity(0.45)
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 1010699)
    }
}
