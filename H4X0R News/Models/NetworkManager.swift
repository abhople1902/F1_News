//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Ayush Bhople on 16/08/23.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_276905e63783667c89744c31c243ef30d05cc&q=Formula%201&language=en&category=sports&image=1") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respose, error) in
                if (error == nil) {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do{
                            let results1 = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results1.results
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
