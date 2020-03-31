//  OptionsView.swift
//  iListUI
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct OptionsView: View {

    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var options: OptionsFactory

    // set default values
    @State private var selectedSorting = SortingType.alphabetical
    @State private var selectedSortingOption = SortingOptionType.descending
    @State private var showWatchedOnly = false
    @State private var showFavouriteOnly = false
    @State private var showFeaturedOnly = false
    @State private var maxPopularity = 5 {
        didSet { // limit the max and min value that the user can selected for popularity filter
            if maxPopularity > 5 { maxPopularity = 5 }
            if maxPopularity < 1 { maxPopularity = 1 }
        }
    }

    let optionsTitle = "Opciones"

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Selecciona los criterios de filtrado")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.regular)) {
                    Toggle(isOn: $showWatchedOnly){
                        Text("Mostrar solo cursos vistos")
                    }
                    Toggle(isOn: $showFavouriteOnly){
                        Text("Mostrar solo cursos favoritos")
                    }
                    Toggle(isOn: $showFeaturedOnly){
                        Text("Mostrar solo cursos destacados")
                    }

                    Stepper(onIncrement: {
                        self.maxPopularity += 1
                    }, onDecrement: {
                        self.maxPopularity -= 1
                    }){
                        HStack {
                            Text("Mostrar")
                            Text("\(String(repeating: AppConfig.popularityChar, count: maxPopularity))")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("o menos")
                        }
                    }
                }

                Section(header: Text("Selectiona los criterios de ordenación")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.regular)) {
                    Picker(selection: $selectedSorting, label: Text("Ordenar")){
                        ForEach(SortingType.allCases, id: \.self){ sortingType in
                            Text(sortingType.description)
                        }
                    }
                    Picker(selection: $selectedSortingOption, label: Text("Mostrar")){
                        ForEach(SortingOptionType.allCases, id: \.self){ sortingOptionType in
                            Text(sortingOptionType.description)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
            }//form
            .navigationBarTitle(optionsTitle)
            //.navigationBarTitle(Text(optionsTitle), displayMode: .inline)
                
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
                self.options.maxPopularity = self.maxPopularity

                self.presentationMode.wrappedValue.dismiss() // close view
                }, label: {
                    Image(systemName: "rectangle.fill.badge.checkmark")
                        .font(Font(UIFont.AppFont.compactTitle))
                })
            )
        
        }//navigation view
        .onAppear { // Load saved options
            self.selectedSorting = self.options.selectedSorting
            self.selectedSortingOption = self.options.selectedSortingOption
            self.showWatchedOnly = self.options.showWatchedOnly
            self.showFavouriteOnly = self.options.showFavouriteOnly
            self.showFeaturedOnly = self.options.showFeaturedOnly
            self.maxPopularity = self.options.maxPopularity
        }

    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView().environmentObject(OptionsFactory())
    }
}
