//  OptionsView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct OptionsView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var options: OptionsFactory

    // Defauls Options values will be set by UserDefaults, not here
    @State private var selectedSorting = SortingType(type: AppConfig.selectedSorting)
    @State private var selectedSortingOption = SortingOptionType(option: AppConfig.selectedSortingOption)
    @State private var showWatchedOnly = AppConfig.showWatchedOnly
    @State private var showFavouriteOnly = AppConfig.showFavouriteOnly
    @State private var showFeaturedOnly = AppConfig.showFeaturedOnly
    @State private var minComicsAvailable = AppConfig.minComicsAvailable

    let optionsTitle = "Sorting and filters"

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Select filters criteria")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)) {
                    Toggle(isOn: $showWatchedOnly){ Text("Show only checked as Wached") }
                    Toggle(isOn: $showFavouriteOnly){ Text("Show only checked as Favourite") }
                    Toggle(isOn: $showFeaturedOnly){ Text("Show only checked as Featured") }

                    Stepper(onIncrement: {
                        self.minComicsAvailable += AppConfig.comicsStepJump
                        if self.minComicsAvailable > AppConfig.comicsMaxStepperValue { self.minComicsAvailable = AppConfig.comicsMaxStepperValue }
                    }, onDecrement: {
                        self.minComicsAvailable -= AppConfig.comicsStepJump
                        if self.minComicsAvailable < AppConfig.comicsMinStepperValue { self.minComicsAvailable = AppConfig.comicsMinStepperValue }
                    }) { Text(String(format: "Show only with at least %d comics available", minComicsAvailable)) }
                }

                Section(header: Text("Select sorting criteria")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)) {

                    Picker(selection: $selectedSorting,
                           label: Text("Sorting by")) {
                            ForEach(SortingType.allCases, id: \.self){ sortingType in
                                Text(sortingType.description)
                            }
                    }

                    Picker(selection: $selectedSortingOption,
                           label: Text("Sorting by")) {
                            ForEach(SortingOptionType.allCases, id: \.self){ sortingOptionType in
                                Text(sortingOptionType.description)
                            }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
            } //form
            .navigationBarTitle(optionsTitle)
                
            .navigationBarItems(
                leading: Button(action: { // left button
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName:"rectangle.dock")
                        .font(.title)
                }),
                trailing: Button(action: { // right button
                
                    // Save Options
                    self.options.selectedSorting = self.selectedSorting
                    self.options.selectedSortingOption = self.selectedSortingOption
                    self.options.showWatchedOnly = self.showWatchedOnly
                    self.options.showFavouriteOnly = self.showFavouriteOnly
                    self.options.showFeaturedOnly = self.showFeaturedOnly
                    self.options.minComicsAvailable = self.minComicsAvailable

                    self.presentationMode.wrappedValue.dismiss() // close view
                    }, label: {
                        Image(systemName: AppConfig.barSaveOptions)
                            .font(Font(UIFont.AppFont.compactTitle))
                    })
                )

        } //navigation view
        .onAppear { // Load saved options
            self.selectedSorting = self.options.selectedSorting
            self.selectedSortingOption = self.options.selectedSortingOption
            self.showWatchedOnly = self.options.showWatchedOnly
            self.showFavouriteOnly = self.options.showFavouriteOnly
            self.showFeaturedOnly = self.options.showFeaturedOnly
            self.minComicsAvailable = self.options.minComicsAvailable
        }

    }
}


struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView().environmentObject(OptionsFactory())
    }
}
