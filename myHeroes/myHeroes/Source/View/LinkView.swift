//  LinkView.swift
//  myHeroes
//
//  Created by Simón Aparicio on 04/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct LinkView: UIViewRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        print(url)
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webview = WKWebView()
        webview.load(request)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
