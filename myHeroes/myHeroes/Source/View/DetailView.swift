//  DetailView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    let detailsTitle = "Details"
    let defaultName = "Nameless Character"
    let defaultDescription = """
                             This character has an empty or nil description, this is a text to supply it…
                             If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable.
                             """

    @ObservedObject var viewModel: DetailViewModel
    
    init(id: Int) {
        self.viewModel = DetailViewModel(id)
    }
    
    var body: some View {
        
                ScrollView {
                    VStack {
                        HeaderImageWidget(url: String(format: "%@.%@", String((viewModel.chartys.first?.thumbnail.path ?? "")), String((viewModel.chartys.first?.thumbnail.thumbnailExtension ?? "")))
                        )

                        HStack {
                            Text(String(format: "%@ comics | %@ events | %@ series", String(viewModel.chartys.first?.comics.items.count ?? 0), String(viewModel.chartys.first?.events.items.count ?? 0), String(viewModel.chartys.first?.series.items.count ?? 0)))
                                .font(.system(.headline, design: .rounded)).fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                        .padding()

                        Text(String(viewModel.chartys.first?.name ?? "no name"))
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.highlighted)
                            .fontWeight(.black)
                            .padding()

                        Text(String(viewModel.chartys.first?.id ?? 0))
                            .font(.system(.title, design: .rounded)).fontWeight(.heavy)
                            .foregroundColor(.secondary)

                        Text(
                            viewModel.chartys.first?.resultDescription.isEmpty ?? false ?
                                defaultDescription :
                                String(viewModel.chartys.first?.resultDescription ?? defaultDescription)
                        )
                            .font(.system(.body, design: .rounded))
                            .padding()

                        Text(String(viewModel.chartys.description))
                            .font(.system(.body, design: .rounded))
                            .padding()
                        
                        Spacer() // to push all the content up
                    }
                }
                .navigationBarTitle(Text(String(format: "%d  %@", viewModel.chartys.first?.id ?? 0, detailsTitle)), displayMode: .inline)
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
            .aspectRatio(contentMode: .fit)
            //.cornerRadius(35)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 1010699)
    }
}
