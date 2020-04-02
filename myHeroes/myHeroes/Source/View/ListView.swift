//  ContentView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 24/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

struct ListView: View {
    
    @State var showOptions: Bool = false
    
    @State var someItems = AnItemsFactory.someItems
    
    @EnvironmentObject var options: OptionsFactory
    
    @ObservedObject var viewModel = HeroesListViewModel()
    
    let listTitle = "Personajes Marvel"
    
    // For the time being, it is still necessary to configure appearance for Navigation Bar
    // with classical UIKit method using an initializer
    init() {
        
        // fonts for navigationbar titles
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.AppFont.largeTitle,
            .foregroundColor: UIColor.barTitles]
        appearance.titleTextAttributes = [
            .font: UIFont.AppFont.compactTitle,
            .foregroundColor: UIColor.barTitles]
        
        // back button
        appearance.setBackIndicatorImage(
            UIImage(systemName: AppConfig.barBack), transitionMaskImage:
            UIImage(systemName: AppConfig.barBackTrans))
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont.AppFont.barButton,
            .foregroundColor: UIColor.barButton]
        //appearance.configureWithTransparentBackground()
        
        // assign appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    func dumpy(_ charty:CharacterListItemDTO){
        dump(charty)
    }
    var body: some View {
        
        NavigationView{
            
            List{
                ForEach(viewModel.chars, id: \.id) { charty in
                    ZStack {
                        VStack {
                            //Text(String(charty.name ?? "default nil value"))
                            CellViewFeatured(charty: charty)
                                .contextMenu {
                                    Button(action: { // watched
                                        self.toggle(charty, type: .watched)
                                    }, label: {
                                        HStack{
                                            Text(charty.watched ? "Marcar como no visto" : "Visto")
                                            Image(systemName: charty.watched ? AppConfig.menuUnWatch : AppConfig.menuWatch)
                                        }
                                    })
                                    Button(action: { // favourite
                                        self.toggle(charty, type: .favourite)
                                    }, label: {
                                        HStack{
                                            Text(charty.favourite ? "Quitar favorito" : "Favorito")
                                            Image(systemName: charty.favourite ? AppConfig.menuUnFav : AppConfig.menuFav)
                                        }
                                    })

                                    Button(action: { // feature
                                        self.toggle(charty, type: .featured)
                                    }, label: {
                                        HStack{
                                            Text(charty.featured ? "No destacar" : "Destacar")
                                            Image(systemName: charty.featured ? AppConfig.menuUnFeat : AppConfig.menuFeat)
                                        }
                                    })

                                    Button(action: { // remove
                                        self.removeItem(item: charty)
                                    }, label: {
                                        HStack{
                                            Text("Eliminar")
                                            Image(systemName: AppConfig.menuRemove)
                                        }
                                    })
                            }
                            .onTapGesture {
                                self.dumpy(charty)
                            }
                        }
                    }
                }
                .onDelete(perform: { (indexSet) in
                    // with onDelete, can delete a Set of items. Remember apply the same filters and sorting as showing before remove an item
                    self.viewModel.chars.remove(atOffsets: indexSet)
                })
            
            }.navigationBarTitle(Text(listTitle))
        
//            List (networkManager.chars, id: \.id){
//                Text(String($0.name ?? "defaultValue for nil"))
//            }.navigationBarTitle(Text(listTitle))
            
//            List{ // need a ForEach instead directly a List to implement onDelete
//
//                ForEach(someItems
//                    .filter(shouldShowItem)
//                    .sorted(by: self.options.selectedSorting.sortingPredicate(
//                        descOrder: self.options.selectedSortingOption.boolMe()))){ item in
//                    //.sorted(by: self.options.selectedSorting.sortingPredicate())){ item in
//                    // Important to filter and sorted in the same way
//                    // before remove with an index (.onDelete indexSet)
//
//                    ZStack {
//                        VStack {
//                            if item.featured {
//                                CellViewTypeTwo(anItem: item)
//                            } else {
//                                CellViewTypeOne(anItem: item)
//                            }
//                        }
//                        .contextMenu{
//
//                            Button(action: { // watched
//                                self.toggle(item, type: .watched)
//                            }, label: {
//                                HStack{
//                                    Text(item.watched ? "Marcar como no visto" : "Visto")
//                                    Image(systemName: item.watched ? AppConfig.menuUnWatch : AppConfig.menuWatch)
//                                }
//                            })
//
//                            Button(action: { // favourite
//                                self.toggle(item, type: .favourite)
//                            }, label: {
//                                HStack{
//                                    Text(item.favourite ? "Quitar favorito" : "Favorito")
//                                    Image(systemName: item.favourite ? AppConfig.menuUnFav : AppConfig.menuFav)
//                                }
//                            })
//
//                            Button(action: { // feature
//                                self.toggle(item, type: .featured)
//                            }, label: {
//                                HStack{
//                                    Text(item.favourite ? "No destacar" : "Destacar")
//                                    Image(systemName: item.featured ? AppConfig.menuUnFeat : AppConfig.menuFeat)
//                                }
//                            })
//
//                            Button(action: { // remove
//                                self.removeItem(item: item)
//                            }, label: {
//                                HStack{
//                                    Text("Eliminar")
//                                    Image(systemName: AppConfig.menuRemove)
//                                }
//                            })
//                        }
//                        //.onTapGesture { // now using a navigation link
//                        //}
//
//                        // this is the only way (right now) to remove or do not show the
//                        // disclouser indicator in the row, first renders the content and
//                        // after this render over an empty view, needed a ZStack to do this
//                        NavigationLink(destination: ItemDetailView(item: item)) {
//                            EmptyView()
//                        }//navigation link
//                    }
//                }//foreach
//                .onDelete(perform: { (indexSet) in // with onDelete, can delete a Set of items
//                    self.removeItem(itemsSet: indexSet)
//                })
//            }//list
//            // the navigation modificators goes in the close bracket of the last component inside the NavigationView
//            .navigationBarTitle(listTitle)
//            .navigationBarItems(trailing:
//                Button(action: {
//                    self.showOptions = true
//                }, label: {
//                    Image(systemName: AppConfig.barShowOptions).font(.title)
//            })
//            )// this modificator is for present Options in modal view and the binded var is necessary to close it
//            .sheet(isPresented: $showOptions){
//                OptionsView().environmentObject(self.options) // dependency injection
//            }
            
        }//navigation view
        
    }
    
    enum ToggleType {
        case watched
        case favourite
        case featured
    }
    
    func toggle(_ item: CharacterListItemDTO, type: ToggleType) {
        
        if let index = self.viewModel.chars.firstIndex(where: { $0.id == item.id }) {
            switch type {
                case .watched: viewModel.chars[index].watched.toggle()
                case .favourite: viewModel.chars[index].favourite.toggle()
                case .featured: viewModel.chars[index].featured.toggle()
            }
        }
    }

    func removeItem(item: CharacterListItemDTO) { // remove an item
        
        self.viewModel.chars.removeAll(where: { charty in
            charty.id == item.id
        })
//        if let index = self.viewModel.chars.firstIndex(where: {$0.id == item.id}){
//            self.viewModel.chars.remove(at: index)
//        }
    }

//    func removeItem(itemsSet: IndexSet) { // remove from .onDelete with and indexSet
//        
//        // When using an index need to filter and sort array previously
//        // >> exactly in the same way that are displayed <<
//        var itemsWithCurrentFilters = self.someItems
//            .filter(shouldShowItem)
//            .sorted(by: self.options.selectedSorting.sortingPredicate(
//                descOrder: self.options.selectedSortingOption.boolMe()))
//        
////        itemsSet.forEach { index in
////            itemsWithCurrentFilters.remove(at: index)
////        }
//        itemsWithCurrentFilters.remove(atOffsets: itemsSet)
//
//        self.someItems = itemsWithCurrentFilters
//    }

    private func shouldShowItem(_ item: AnItem) -> Bool {
        let checkWatched = (self.options.showWatchedOnly && item.watched) || !self.options.showWatchedOnly
        let checkFavourite = (self.options.showFavouriteOnly && item.favourite) || !self.options.showFavouriteOnly
        let checkFeatured = (self.options.showFeaturedOnly && item.featured) || !self.options.showFeaturedOnly
        let checkPopularity = (item.popularity <= self.options.maxPopularity)
        return checkWatched && checkFavourite && checkFeatured && checkPopularity
    }
   
}

// MARK: - Cell Views

struct CellViewTypeOne: View {
    
    var anItem: AnItem
    
    var body: some View {
        HStack {
            Image(anItem.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(40) // half of widht to circle

            VStack(alignment: .leading, spacing: 1){
                Text(anItem.author)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.highlighted)
                    .fontWeight(.bold)
                    .lineLimit(1)
                HStack {
                    VStack {
                        Text(anItem.title)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.regular)
                            .lineLimit(3)
                        Spacer()
                    }
                    
                    // needed to push to the left description and image and icons view to the right
                    Spacer().layoutPriority(-10)
                    
                    VStack(alignment: .trailing, spacing: 1) {
                        Spacer() // push icons view down
                        HStack {
                            if anItem.favourite {
                                Image(systemName: AppConfig.cellFav)
                                    .foregroundColor(.star)
                                .padding(.bottom, 4)
                            }
                            if anItem.watched {
                                Image(systemName: AppConfig.cellWatched)
                                    .foregroundColor(.eye)
                                .padding(.bottom, 4)
                            }
                        }//hstack
                        
                        Text(String(anItem.type))
                            .font(.system(.subheadline, design: .rounded)).bold()
                            .padding(.vertical, 1)
                        
                        Text(String(repeating: AppConfig.popularityChar, count: anItem.popularity))
                            .font(.subheadline)//.fontWeight(.black)
                            .padding(.top, 1)
                        Spacer() // push icons view up to center vertically
                    }//vstack
                    .foregroundColor(.secondary)
                    
                }//hstack
            }//vstack
        }//hstack
        
    }
}

class ImageLoader: ObservableObject {

//    var didChange = PassthroughSubject<Data, Never>()
//
//    @Published var data = Data() {
//        didSet {
//            didChange.send(data)
//        }
//    }

    @Published var data = Data()
    
    init(url: String) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

struct ImageViewWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
        print(url)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data.count == 0) ? UIImage(named: "placeholder")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .opacity(0.55)
        )
    }
}

struct CellViewFeatured: View {
    
    var charty: CharacterListItemDTO
    
    var body: some View {
        ZStack {
            ImageViewWidget(url: String(format: "%@.%@", String(charty.thumbnail!.path), String(charty.thumbnail!.thumbnailExtension)))
            
            VStack(alignment: .center, spacing: 1){
                Text(String(charty.name ?? "default name"))
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.white)

                Text(String(charty.resultDescription ?? "default description"))
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Spacer()
                HStack(alignment: .center, spacing: 5) {
                    HStack {
                        if charty.favourite  { Image(systemName: AppConfig.cellFav) }
                        if charty.watched { Image(systemName: AppConfig.cellWatched) }
                    }
                    Spacer()
                    //Text(String(repeating: "", count: charty.comics.items.count))
                    Text(String(format: "%@ comics | %@ eventos | %@ series", String(charty.comics.items.count), String(charty.events?.count ?? 0), String(charty.series?.count ?? 0)))
                }
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.white)
//                Text(String(charty.id))
//                Text(String(charty.thumbnail?.path ?? "default thumbnail"))
//                Text(String(charty.thumbnail?.thumbnailExtension ?? "default extension"))
            }//vstack
        .padding()
        }//zstack
    }
}

struct CellViewTypeTwo: View {
    
    var anItem: AnItem
    
    var body: some View {
        
        ZStack {
            Image(anItem.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.gray)
                        .opacity(0.55)
            )

            VStack(alignment: .leading, spacing: 1){
                Text(anItem.author)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text(anItem.title)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                Spacer()
                HStack(alignment: .center, spacing: 5) {
                    HStack {
                        if anItem.favourite  { Image(systemName: AppConfig.cellFav) }
                        if anItem.watched { Image(systemName: AppConfig.cellWatched) }
                    }
                    Spacer()
                    Text(String(repeating: "", count: anItem.popularity))
                    Text(String("| " + anItem.type))
                }
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.white)//(Color(.systemPink))
            }//vstack
            .padding()
        }//zstack
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(OptionsFactory()) // dependency injection
    }
}
