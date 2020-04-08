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
                ZStack(alignment: .bottom) {
                    
                    ZStack {
                        HeaderImageWidget(url: String(format: "%@.%@", String((viewModel.charty.thumbnail.path)), String((viewModel.charty.thumbnail.thumbnailExtension)))
                        )
                    }
                    
                    VStack(alignment: .center, spacing: 1) {
                        Spacer()
                        HStack(alignment: .top, spacing: 5) {
                            Spacer()
                            VStack(alignment: .trailing){
                                Text(String(viewModel.charty.name))
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                Text(String(viewModel.charty.id))
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.trailing)
                                Text(viewModel.charty.resultDescription.isEmpty ? defaultDescription : String(viewModel.charty.resultDescription))
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    .padding()
                    .padding(.vertical, 50)
                    
                    Picker(selection: $selectedItemList, label: Text("Select an items list")){
                        ForEach(ItemListType.allCases, id: \.self){ itemListType in
                            Text(itemListType.description)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color.segmentedPickerBackground)
                    .pickerStyle(SegmentedPickerStyle())

                } //zstack
            }
            VStack{
                if self.selectedItemList.selectedItemList(self.viewModel.charty).isEmpty {
                    EmptyComicsItemList(type: selectedItemList.description)
                    Spacer()
                } else {
                    List(selectedItemList.selectedItemList(viewModel.charty), id: \.id) { item in
                        VStack {
                            ComicCellView(name: item.id, resourceURI: item.resourceURI)
                        }
                        .onTapGesture {
                            self.selectedComicsItem = item
                            self.showLink = true // this will triger the modal sheet
                        }
                    } // list
                }
            } // vstack
            .padding(.horizontal)
            
        } // vstack
        //.navigationBarTitle(Text(String(format: "%@", viewModel.charty.name)), displayMode: .inline)
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
        Image(uiImage: (imageLoader.data.isEmpty) ? UIImage(named: "placeholder")! : UIImage(data: imageLoader.data)!)
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 1010699)
    }
}
