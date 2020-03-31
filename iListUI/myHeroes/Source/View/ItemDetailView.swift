//  ItemDetailView.swift
//  iListUI
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {

    var item: AnItem

    let detailsTitle = "Más detalles"

    var body: some View {
        
                ScrollView {
                    VStack {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        HStack {

                            Text(item.type)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)

                            Text(String(item.popularity))
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)
                            
                            Text(String(item.featured))
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)

                            Text(String(item.watched))
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)

                            Text(String(item.favourite))
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)
                        }
                        .padding()

                        Text(item.author)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.highlighted)
                            .fontWeight(.black)
                            .padding()

                        Text(item.title)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .padding()
                        
                        Text(item.description)
                            .font(.system(.body, design: .rounded))
                            .padding()
                        
                        Spacer() // to push all the content up
                    }
                }
                .navigationBarTitle(Text(detailsTitle), displayMode: .inline)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: AnItem(image: "imagen01",
        author: "Pedro Alonso Domínguez",
        title: "Ingeniería mecánica para pilotos incapacitados por alcoholemia",
        description: AnItemsFactory.RandomDescription(Int.random(in: 0...3)).description,
        type: "tipoD",
        popularity: 2,
        watched: true,
        favourite: true)
        )
    }
}
