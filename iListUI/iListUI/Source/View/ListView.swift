//  ContentView.swift
//  iListUI
//
//  Created by Simón Aparicio on 24/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State var showOptions: Bool = false
    
    @State var someItems = AnItemsFactory.someItems
    
    @EnvironmentObject var options: OptionsFactory
    
    let listTitle = "Items super chulos!"
    
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
    
    var body: some View {
        
        NavigationView{
            
            List{ // need a ForEach instead directly a List to implement onDelete
                
                ForEach(someItems
                    .filter(shouldShowItem)
                    .sorted(by: self.options.selectedSorting.sortingPredicate(
                        descOrder: self.options.selectedSortingOption.boolMe()))){ item in
                    //.sorted(by: self.options.selectedSorting.sortingPredicate())){ item in
                    // Important to filter and sorted in the same way
                    // before remove with an index (.onDelete indexSet)

                    ZStack {
                        VStack {
                            if item.featured {
                                CellViewTypeTwo(anItem: item)
                            } else {
                                CellViewTypeOne(anItem: item)
                            }
                        }
                        .contextMenu{
                            
                            Button(action: { // watched
                                self.toggle(item, type: .watched)
                            }, label: {
                                HStack{
                                    Text(item.watched ? "Marcar como no visto" : "Visto")
                                    Image(systemName: item.watched ? AppConfig.menuUnWatch : AppConfig.menuWatch)
                                }
                            })
                            
                            Button(action: { // favourite
                                self.toggle(item, type: .favourite)
                            }, label: {
                                HStack{
                                    Text(item.favourite ? "Quitar favorito" : "Favorito")
                                    Image(systemName: item.favourite ? AppConfig.menuUnFav : AppConfig.menuFav)
                                }
                            })
                            
                            Button(action: { // feature
                                self.toggle(item, type: .featured)
                            }, label: {
                                HStack{
                                    Text(item.favourite ? "No destacar" : "Destacar")
                                    Image(systemName: item.featured ? AppConfig.menuUnFeat : AppConfig.menuFeat)
                                }
                            })
                            
                            Button(action: { // remove
                                self.removeItem(item: item)
                            }, label: {
                                HStack{
                                    Text("Eliminar")
                                    Image(systemName: AppConfig.menuRemove)
                                }
                            })
                        }
                        //.onTapGesture { // now using a navigation link
                        //}

                        // this is the only way (right now) to remove or do not show the
                        // disclouser indicator in the row, first renders the content and
                        // after this render over an empty view, needed a ZStack to do this
                        NavigationLink(destination: ItemDetailView(item: item)) {
                            EmptyView()
                        }//navigation link
                    }
                }//foreach
                .onDelete(perform: { (indexSet) in // with onDelete, can delete a Set of items
                    self.removeItem(itemsSet: indexSet)
                })
            }//list
            // the navigation modificators goes in the close bracket of the last component inside the NavigationView
            .navigationBarTitle(listTitle)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showOptions = true
                }, label: {
                    Image(systemName: AppConfig.barShowOptions).font(.title)
            })
            )// this modificator is for present Options in modal view and the binded var is necessary to close it
            .sheet(isPresented: $showOptions){
                OptionsView().environmentObject(self.options) // dependency injection
            }
            
        }//navigation view
        
    }
    
    enum ToggleType {
        case watched
        case favourite
        case featured
    }
    
    func toggle(_ item: AnItem, type: ToggleType) {
        
        if let index = self.someItems.firstIndex(where: { $0.id == item.id }) {
            switch type {
                case .watched: someItems[index].watched.toggle()
                case .favourite: someItems[index].favourite.toggle()
                case .featured: someItems[index].featured.toggle()
            }
        }
    }

    func removeItem(item: AnItem) { // remove an item
        
        someItems.removeAll(where: { anItem in
            anItem.id == item.id
        })
//        if let index = self.someItems.firstIndex(where: {$0.id == item.id}){
//            self.someItems.remove(at: index)
//        }
    }

    func removeItem(itemsSet: IndexSet) { // remove from .onDelete with and indexSet
        
        // When using an index need to filter and sort array previously
        // >> exactly in the same way that are displayed <<
        var itemsWithCurrentFilters = self.someItems
            .filter(shouldShowItem)
            .sorted(by: self.options.selectedSorting.sortingPredicate(
                descOrder: self.options.selectedSortingOption.boolMe()))
        
//        itemsSet.forEach { index in
//            itemsWithCurrentFilters.remove(at: index)
//        }
        itemsWithCurrentFilters.remove(atOffsets: itemsSet)

        self.someItems = itemsWithCurrentFilters
    }

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
