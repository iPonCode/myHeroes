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
                                        self.viewModel.toggle(charty, type: .featured)
                                    }
                                }, label: {
                                    HStack{
                                        Text(charty.featured ? "No destacar" : "Destacar")
                                        Image(systemName: charty.featured ? AppConfig.menuUnFeat : AppConfig.menuFeat)
                                    }
                                })

                                Button(action: { // watched
                                    self.viewModel.toggle(charty, type: .watched)
                                }, label: {
                                    HStack{
                                        Text(charty.watched ? "Marcar como no visto" : "Visto")
                                        Image(systemName: charty.watched ? AppConfig.menuUnWatch : AppConfig.menuWatch)
                                    }
                                })
                                Button(action: { // favourite
                                    self.viewModel.toggle(charty, type: .favourite)
                                }, label: {
                                    HStack{
                                        Text(charty.favourite ? "Quitar favorito" : "Favorito")
                                        Image(systemName: charty.favourite ? AppConfig.menuUnFav : AppConfig.menuFav)
                                    }
                                })

                                Button(action: { // remove
                                    self.viewModel.removeItem(item: charty)
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


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(OptionsFactory()) // dependency injection
    }
}
