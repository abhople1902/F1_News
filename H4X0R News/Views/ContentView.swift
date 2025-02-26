//
//  ContentView.swift
//  H4X0R News
//
//  Created by Ayush Bhople on 16/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.link)) {
                    HStack {
                        Text(post.title)
                    }
                }
            }
            .navigationBarTitle("F1 News")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

