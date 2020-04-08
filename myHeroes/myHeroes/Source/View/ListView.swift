//  ContentView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 24/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State var showOptions: Bool = false
    @EnvironmentObject var options: OptionsFactory
    @ObservedObject var viewModel = ListViewModel()
    
    let listTitle = "Marvel Characters"
    
    // For the time being, it is still necessary to configure appearance for Navigation Bar
    // with classical UIKit method using an initializer
    init() {
        ConfigureNavigationBarAppearance()
    }

    var body: some View {
        NavigationView{
            
            if viewModel.chars.isEmpty { // while list is loading this view will be displayed
                EmptyCharactersList(error: viewModel.serverError) // if webservice fail, also shows the error
                Spacer()
                
            } else { // once have data it has been displayed with its corresponding filters and sorting order applied
                List{
                    ForEach(viewModel.chars
                        .filter(shouldShowItem)
                        .sorted(by: self.options.selectedSorting.sortingPredicate(
                            descOrder: self.options.selectedSortingOption.boolMe()))){ charty in
                        // Important to filter and sorteing in the same way
                        // before remove with an index or an indexSet (.onDelete)

                        ZStack {
                            VStack {
                                if charty.featured {
                                    FeaturedCellView(charty: charty).transition(.featuredCell)
                                } else {
                                    StandardCellView(charty: charty).transition(.standardCell)
                                }
                            }
                            .contextMenu {
                                Button(action: { // feature
                                    withAnimation(Animation.easeInOut.speed(AppConfig.animationSpeedFactor)) {
                                        self.toggle(charty, type: .featured)
                                    }
                                }, label: {
                                    HStack{
                                        Text(charty.featured ? "No destacar" : "Destacar")
                                        Image(systemName: charty.featured ? AppConfig.menuUnFeat : AppConfig.menuFeat)
                                    }
                                })

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

                                Button(action: { // remove
                                    self.removeItem(item: charty)
                                }, label: {
                                    HStack{
                                        Text("Eliminar")
                                        Image(systemName: AppConfig.menuRemove)
                                    }
                                })
                            }
                            // this is the only way (right now) to remove or do not show the
                            // disclouser indicator in the row, first renders the content and
                            // after this render over an empty view, needed a ZStack to do this
                            NavigationLink(destination: DetailView(id: charty.id)) {
                                EmptyView()
                            } //navigation link
                            
                        } //zstack
                                
                    } // need a ForEach instead directly a List to implement onDelete
                    .onDelete(perform: { (indexSet) in
                        // with onDelete, can delete a Set of items
                        self.removeItem(itemsSet: indexSet)
                    })
                    
                } //list
                // the navigation modificators goes in the close bracket of the last component inside the NavigationView
                .navigationBarTitle(Text(listTitle))
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
            } //if-else (empty list)
        } //navigation view
        // to remove the cell separators
        .onAppear { UITableView.appearance().separatorStyle = .none }
        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
    } //body
    
    private func ConfigureNavigationBarAppearance() {
        
        let appearance = UINavigationBarAppearance()

        // fonts for navigationbar titles
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

        // transparency
        appearance.configureWithTransparentBackground()

        // apply appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
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
    }

    func removeItem(itemsSet: IndexSet) { // remove from .onDelete with and indexSet
        
        // When using an index need to filter and sort array previously
        // >> exactly in the same way that are displayed <<
        var itemsWithCurrentFilters = viewModel.chars
            .filter(shouldShowItem)
            .sorted(by: self.options.selectedSorting.sortingPredicate(
                descOrder: self.options.selectedSortingOption.boolMe()))
        
        itemsWithCurrentFilters.remove(atOffsets: itemsSet)
        viewModel.chars = itemsWithCurrentFilters
    }

    private func shouldShowItem(_ item: CharacterListItemDTO) -> Bool {
        let checkWatched = (self.options.showWatchedOnly && item.watched) || !self.options.showWatchedOnly
        let checkFavourite = (self.options.showFavouriteOnly && item.favourite) || !self.options.showFavouriteOnly
        let checkFeatured = (self.options.showFeaturedOnly && item.featured) || !self.options.showFeaturedOnly
        let checkComicsAvailable = (item.comics.available >= self.options.minComicsAvailable)
        return checkWatched && checkFavourite && checkFeatured && checkComicsAvailable
    }
   
}

// MARK: - Cell Views

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


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(OptionsFactory()) // dependency injection
    }
}
