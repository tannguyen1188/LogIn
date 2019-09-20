//
//  Image.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation



struct Image: Decodable {
    
    let thumbnailUrl: String
    let url: String
    let title: String
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl
        case url
        case title
    }
    init(from core: CoreData){
        let title = core.value(forKey: "title") as! String
        let url = core.value(forKey: "url") as! String
        let thumbnailUrl = core.value(forKey: "thumbnailUrl") as! String
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}

extension Image: Equatable {
    static func ==(lhs: Image, rhs: Image) -> Bool {
        return lhs.thumbnailUrl == rhs.thumbnailUrl
            && lhs.url == rhs.url
            && lhs.title == rhs.title
    }
}
