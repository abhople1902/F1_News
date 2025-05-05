//
//  PostData.swift
//  H4X0R News
//
//  Created by Ayush Bhople on 16/08/23.
//

import Foundation

struct Results: Decodable {
    let results: [Post]
    
}

struct Post: Decodable, Identifiable {
    var id: String {
        return title
    }
    let source_priority: Int
    let title: String
    let link: String?
    let image_url: String
}
