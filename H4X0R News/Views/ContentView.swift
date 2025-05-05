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
            ZStack {
                // Main List
                List(networkManager.posts) { post in
                    NavigationLink(destination: DetailView(url: post.link)) {
                        VStack(alignment: .leading, spacing: 8) {
                            // Use AsyncImage for remote URLs
                            AsyncImage(url: URL(string: post.image_url)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                                        .clipped()
                                } else if phase.error != nil {
                                    // Error placeholder
                                    Color.red
                                        .frame(height: 150)
                                } else {
                                    // Loading placeholder
                                    ProgressView()
                                        .frame(height: 150)
                                }
                            }
                            .background(Color(.systemGray6))

                            Text(post.title)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .navigationBarTitle("F1 News")

                // Overlay ProgressView while loading
                if networkManager.posts.isEmpty {
                    VStack {
                        ProgressView("Loading Articles...")
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground).opacity(0.6))
                }
            }
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
