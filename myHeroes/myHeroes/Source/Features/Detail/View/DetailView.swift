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


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 1010699)
    }
}
