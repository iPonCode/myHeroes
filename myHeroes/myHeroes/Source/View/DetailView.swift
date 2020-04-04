//  DetailView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @ObservedObject var viewModel: DetailViewModel
    @State private var selectedItemList = ItemListType.comics
    @Environment(\.presentationMode) var presentationMode
    @State var showLink: Bool = false
    @State var selectedComicsItem: ComicsItemDTO?

    let defaultDescription = "This character has an empty or nil description, this is a text to supply it…"

    init(id: Int) {
        self.viewModel = DetailViewModel(id)
    }
    
    var body: some View {
        
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
                        .frame(height: 50)
                        .background(Color.segmentedPickerBackground)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    VStack(alignment: .center, spacing: 1) {
                        Spacer()
                        HStack(alignment: .top, spacing: 5) {
                            Spacer()
                            VStack(alignment: .trailing){
                                Text(String(viewModel.chartys[0].name))
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                Text(String(viewModel.chartys[0].id))
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.trailing)
                                Text(viewModel.chartys[0].resultDescription.isEmpty ? defaultDescription : String(viewModel.chartys[0].resultDescription))
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                    //.lineLimit(4)
                            }
                        }
                    }
                    .padding()
                    .padding(.vertical, 50)
                } //zstack
            }
            VStack{
                List(selectedItemList.selectedItemList(viewModel.chartys[0]), id: \.id) { item in
                    ComicCellView(name: item.id, resourceURI: item.resourceURI)
                        .onTapGesture {
                            self.selectedComicsItem = item
                            self.showLink = true
                            print("link cell tapped: \(item.id) --> \(item.resourceURI)")
                    }
                } // list
                // this modificator is for present Webview in modal view and the binded var is necessary to close it
                .sheet(isPresented: self.$showLink){
                    if self.selectedComicsItem != nil {
                        
                        //LinkView(url: self.viewModel.getComicsItemUrl(self.selectedComicsItem!.resourceURI))
                        LinkView(url: ApiConfig.charactersWebSearchUrl)
                    }
                }
            } // vstack
            .padding(.horizontal)
        } // vstack
        //.navigationBarTitle(Text(String(format: "%@", viewModel.chartys[0].name)), displayMode: .inline)
        .edgesIgnoringSafeArea(.top) // the top image goes up
        .navigationBarBackButtonHidden(true) // will create a custom back button
        .navigationBarItems(leading:
        Button(action: { // go back using this environment var (SwiftUI)
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: AppConfig.barBack)
                .font(.largeTitle)
                .foregroundColor(.barBackButton)
        })
        )

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
